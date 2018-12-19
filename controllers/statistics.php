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
		$this->display('index.tpl');
	}

	/**
	 * Сохранить протокол статистики
	 */
	public function save() {
		$Csv = new Csv($_FILES['csv']);
		$data = $Csv->getArray();
		$data = $this->_getCorrectKeyArray($data);
		$this->vd($data);exit;
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
	 * Установка корректных названий элементам массива
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
		}

		return $finalData;
	}
}