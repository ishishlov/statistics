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
		$notConfirmedProtocol = $this->_model->getNotConfirmedProtocolData();
		$this->_data['isShowLoadButton'] = (bool)!$notConfirmedProtocol;
		$this->display('index.tpl');
	}

	/**
	 * Временная страница с формой сохранения протокола статистики
	 */
	public function commandsStatisticCopy() {
		$seasonStatistics = $this->_model->getSeasonsStatistic(17, 1);
		$gamesStatistics = $this->_model->getGamesStatistic(17, [1,2]);
		//$this->vd($gamesStatistics);exit;
		$this->display('commandstatisticcopy.tpl');
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
			'gamesStatistic'	=> $this->_model->getGamesStatistic($seasonId, $tournamentIds)
		]);
	}

	/**
	 * Страница статистики игроков
	 */
	public function playersStatistic() {
		$this->_data['allSeasons'] = $this->_model->getAllSeasons();
		$this->_data['seasonsStatistic'] = $this->_model->getSeasonsStatistic(17, 1);
		$this->_data['playersStatistic'] = $this->_model->getPlayersStatistic(17, [1,2]);

		$this->display('playersstatistic.tpl');
	}

	public function getPlayersStatistic() {
		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'playersStatistic'	=> $this->_model->getPlayersStatistic($seasonId, $tournamentIds)
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
	public function save() {
		$Csv = new Csv($_FILES['csv']);
		$data = $Csv->getArray();
		$data = $this->_getCorrectKeyArray($data);
		$data = $this->_removeFirstRow($data);
		$errors = $this->_validateArrayData($data);
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
		$test = Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS_STATISTIC);
		$test2 = Cache::deleteValue(StatisticsModel::CACHE_KEY_GAMES_STATISTIC);
		$test3 = Cache::deleteValue(StatisticsModel::CACHE_KEY_PLAYERS_STATISTIC);
		var_dump('Delete is completed');exit;
	}
}