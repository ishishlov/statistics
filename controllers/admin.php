<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';
require_once 'models/csv.php';
require_once 'models/cache.php';

class Admin extends Common {
	
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
     * Страница показа формы для добавления результата игры
     */
    public function addGameResult() {
        $this->_data['teams'] = $this->_model->getTeams();
        $this->_data['nowDate'] = date('Y-m-d');
        $this->_data['seasons'] = $this->_model->getAllSeasons();
        $this->_data['tournaments'] = $this->_model->getTournaments();

        $this->display('addgameresult.tpl');
    }

    /**
     * Добавления результата игры
     */
    public function ajaxAddHistoryGame() {
        $data[0] = [
            'team_id_one'   => (int) $_POST['teamIdOne'],
            'team_id_two'   => (int) $_POST['teamIdTwo'],
            'score_one'     => (int) $_POST['scoreOne'],
            'score_two'     => (int) $_POST['scoreTwo'],
            'tournament_id' => (int) $_POST['tournamentId'],
            'season_id'     => (int) $_POST['seasonId'],
            'dt'            => $_POST['dt'],
        ];

        $this->toJson([
            'result'    => $this->_model->addHistoryGame($data),
            'error'     => 'Ошибка при добавлении'
        ]);
    }

    /**
     * Метод для чистки всего кеша
     */
    public function tempDeleteAllCache() {
        Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS_STATISTIC);
        Cache::deleteValue(StatisticsModel::CACHE_KEY_GAMES_STATISTIC);
        Cache::deleteValue(StatisticsModel::CACHE_KEY_PLAYERS_STATISTIC);
        Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS);
        var_dump('Delete is completed');exit;
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


    private function _convertMinToSec($time) {
        $time = substr($time, 0, -3);
        $sec = (int) substr($time, -2, 2);
        $min = substr($time, 0, 2);
        $min = (int) trim($min, ':');

        return $min * 60 + $sec;
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
}