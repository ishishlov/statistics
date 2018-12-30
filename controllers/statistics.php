<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';
require_once 'models/csv.php';

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
	public function commandStatisticsCopy() {
		$seasonStatistics = $this->_model->getSeasonStatistics(17, 1);
		$gamesStatistics = $this->_model->getGamesStatistics(17, [1,2]);
		//$this->vd($gamesStatistics);exit;
		$this->display('commandstatisticscopy.tpl');
	}

	/**
	 * Страница с формой сохранения протокола статистики
	 */
	public function commandStatistics() {
		$seasonStatistics = $this->_model->getSeasonStatistics(17, 1);
		$gamesStatistics = $this->_model->getGamesStatistics(17, [1,2]);
		//$this->vd($gamesStatistics);exit;
		$this->display('commandstatistics.tpl');
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
		$this->vd($res);exit;
	}

	/**
	 * Получить статистику
	 */
	public function get() {
		$data = $this->_model->get();
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
		exit;
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
			$finalData[$key1][StatisticsModel::FIELDS[28]] = StatisticsModel::STATUS_NOT_CONFIRMED;
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
		//$this->vd($temp1);exit;
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
}