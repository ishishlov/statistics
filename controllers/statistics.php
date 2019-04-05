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
		$notConfirmedData = $this->_model->getNotConfirmedSeasonsStatistic();
		//$this->vd($notConfirmedData);exit;

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
		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'gamesData'         => $this->_model->getGamesData($seasonId, $tournamentIds)
		]);
	}

	public function getPlayersStatistic() {
		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'playersStatistic'	=> $this->_model->getPlayers($seasonId, $tournamentIds)
		]);	
	}

    public function getPlayerData() {
        $playerId= (int) $_POST['playerId'];
        $seasonId = (int) $_POST['seasonId'];
        $tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

        $this->toJson([
            'playerStatistic'	=> $this->_model->getPlayerStatistic($playerId, $seasonId, $tournamentIds),
            'playerInfo'        => $this->_model->getPlayer($playerId)
        ]);
    }

	public function getAllSeasons() {
		$this->toJson([
			'allSeasons' => $this->_model->getAllSeasons()
		]);
	}

	public function getTournaments() {
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
		//$this->vd($data);exit;
		if ($errors) {
			$this->vd('Ошибка');exit;
		}
		$res = $this->_model->save($data);
		//$this->vd($res);exit;
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
			}
			$finalData[$key1][StatisticsModel::FIELDS[29]] = StatisticsModel::STATUS_NOT_CONFIRMED;
		}

		return $finalData;
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
		
		return $errors;
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