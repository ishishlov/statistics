<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';
require_once 'models/csv.php';
require_once 'models/cache.php';

class Statistics extends Common {
	
	private $_model = null;
	
	public function __construct() {
		$this->_model = new StatisticsModel();
	}

	/**
	 * Страница с формой сохранения протокола статистики
	 */
	public function index() {
		if (isset($_POST['saveProtocol'])) {
			$this->_save();
		}
		if (isset($_POST['cancel'])) {
			$this->_model->deleteNotConfirmedProtocol();
		}
		if (isset($_POST['confirmed'])) {
			$this->_model->confirmedProtocol();
		}
        if (isset($_POST['errors'])) {
            $this->_data['errors'] = $_POST['errors'];
        }

		$notConfirmedData = $this->_model->getNotConfirmedSeasonsStatistic();

		$this->_data['isShowLoadButton'] = (bool)!$notConfirmedData;
		$this->_data['notConfirmedData'] = $notConfirmedData;
		$this->display('index.tpl');
	}

	/**
	 * Страница командной статистики
	 */
	public function commandsStatistic() {
		$this->display('commandsstatistic.tpl');
	}

	public function getCommandsStatistic() {
        header('Access-Control-Allow-Origin: *');

		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'gamesData'         => $this->_model->getGamesData($seasonId, $tournamentIds)
		]);
	}

	public function getPlayersStatistic() {
        header('Access-Control-Allow-Origin: *');

		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'playersStatistic'	=> $this->_model->getPlayers($seasonId, $tournamentIds)
		]);	
	}

    public function getPlayerData() {
        header('Access-Control-Allow-Origin: *');

        $playerId= (int) $_POST['playerId'];
        $seasonId = (int) $_POST['seasonId'];
        $tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

        $this->toJson([
            'playerStatistic'	    => $this->_model->getPlayerStatistic($playerId, $seasonId, $tournamentIds),
            'playerGamesStatistic'	=> $this->_model->getPlayerGamesStatistic($playerId, $seasonId, $tournamentIds),
            'playerInfo'            => $this->_model->getPlayer($playerId)
        ]);
    }

	public function getGameInfo() {
        header('Access-Control-Allow-Origin: *');

		$gameId = (int) $_POST['gameId'];
		$this->toJson([
            'gameInfo'	=> $this->_model->getGameInfo($gameId),
        ]);
	}

	public function getAllSeasons() {
        header('Access-Control-Allow-Origin: *');

		$this->toJson([
			'allSeasons' => $this->_model->getAllSeasons()
		]);
	}

	public function getTournaments() {
        header('Access-Control-Allow-Origin: *');

		$this->toJson([
			'tournaments' => $this->_model->getTournaments()
		]);
	}

	/**
	 * Сохранить протокол статистики
	 */
	private function _save() {
		$Csv = new Csv($_FILES['csv']);
		$data = $Csv->getArray();
		$data = $this->_getCorrectKeyArray($data);
		$data = $this->_removeFirstRow($data);
		$errors = $this->_validateArrayData($data);

		if ($errors) {
		    $_POST['errors'] = $errors;
		} else {
            if (!$this->_model->save($data)) {
                $_POST['errors'][] = [
                    'text'  => 'No saved. Please try again',
                    'value' => ''
                ];
            }

        }
	}

	/**
	 * Скачать образец протокола
	 */
	public function loadProtocol() {
		$file = 'files/test.csv';
		header("Content-type: text/csv");
		header('Content-Disposition: attachment; filename="test.csv"');
		readfile($file);
	}

	/**
	 * Установка корректных названий элементам массива и добавление поле "статус"
	 * 
	 * @param array $data
	 * @return array
	 */
	private function _getCorrectKeyArray($data) {
		if (!$data) {
			return [];
		}

		$finalData = [];
		foreach ($data as $key1 => $row) {
			foreach ($row as $key2 => $value) {
				$finalData[$key1][StatisticsModel::FIELDS[$key2]] = mb_convert_encoding($value, "utf-8", "windows-1251");
				// Конвертируем время в секунды
				if ($key2 === 7) {
					$finalData[$key1][StatisticsModel::FIELDS[$key2]] = $this->_convertMinToSec($value);
				}
			}
			$finalData[$key1][StatisticsModel::FIELDS[29]] = StatisticsModel::STATUS_NOT_CONFIRMED;
		}

		return $finalData;
	}
	
	private function _convertMinToSec($time) {
		$time = substr($time, 0, -3);
		$sec = (int) substr($time, -2, 2);
		$min = substr($time, 0, 2);
		$min = (int) trim($min, ':');

		return $min * 60 + $sec;
	}

	/**
	 * Удалить первую строку если она состоит из заголовков
	 * 
	 * @param array $data
	 * @return array
	 */
	private function _removeFirstRow($data) {
		$temp = (int)$data[0][StatisticsModel::FIELDS[0]];
		if (!$temp) {
			array_shift($data);
		}
		return $data;
	}

	/**
	 * Проверка на корректность заполнения полей
	 * 
	 * @param type $data
	 * @return array
	 */
	private function _validateArrayData($data) {
		$errors = [];

        $this->_checkEmptyData($data, $errors);
        $this->_checkDuplicationGameId($data, $errors);

		return $errors;
	}

    /**
     * Проверка на пустоту
     *
     * @param array $data
     * @param array $errors
     */
    private function _checkEmptyData($data, &$errors)
    {

        if (!$data) {
            $error = [
                'text'      => 'No data for insert',
                'value'    => ''
            ];
            $errors[] = $error;
        }
	}

    /**
     * Проверка на дубли (данные внесены ранее)
     *
     * @param array $data
     * @param array $errors
     */
	private function _checkDuplicationGameId($data, &$errors) {
        $newGameIds = [];
        foreach ($data as $row) {
            $newGameIds[] = (int) $row[StatisticsModel::FIELDS[0]];
        }
        $newGameIds = array_unique($newGameIds);
        $duplicateGameIds = $this->_model->getGameIds($newGameIds);

        if ($duplicateGameIds) {
            $error = [
                'text'      => 'Some games have been saved previously',
                'value'    => implode(', ', $duplicateGameIds)
            ];
            $errors[] = $error;
        }
    }

	/**
	 * Временный метод для чистки всего кеша
	 */
	public function tempDeleteAllCache() {
		Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS_STATISTIC);
		Cache::deleteValue(StatisticsModel::CACHE_KEY_GAMES_STATISTIC);
		Cache::deleteValue(StatisticsModel::CACHE_KEY_PLAYERS_STATISTIC);
		Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS);
		var_dump('Delete is completed');exit;
	}
}