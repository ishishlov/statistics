<?php

class Csv {
	
	private $_name = '';
	private $_ext = '';
	private $_type = '';
	private $_tmpName = '';

	public function __construct($csv) {
		$this->_name = $csv['name'];
		$this->_ext = strtolower(end(explode('.', $csv['name'])));
		$this->_type = $csv['type'];
		$this->_tmpName = $csv['tmp_name'];
	}

	/**
	 * Получение массива данных из csv файла
	 * 
	 * @return array
	 */
	public function getArray() {
		$csvArray = $this->parseCsv();
		return $this->getArrayByCsvArray($csvArray);
	}

	/**
	 * Парсинг csv файла
	 * 
	 * @return array
	 */
	public function parseCsv() {
		$csvArray = [];

		if($_FILES['csv']['error'] == 0 &&
			$this->_ext === 'csv' &&
			($handle = fopen($this->_tmpName, 'r')) !== false
		){
			set_time_limit(0);
			$row = 0;
			while(($data = fgetcsv($handle, 1000)) !== false) {
				$csvArray[] = $data[0];
				$row++;
			}
			fclose($handle);
		}
		return $csvArray;
	}

	/**
	 * Получить массив данных с правильными ключами
	 * 
	 * @param array $csvArray
	 * @return array
	 */
	public function getArrayByCsvArray($csvArray) {
		if (!$csvArray || !is_array($csvArray)) {
			return [];
		}

		$dataArray = [];
		foreach ($csvArray as $dataString) {
			$dataArray[] = explode(';', $dataString);
		}
		
		return $dataArray;
	}
	
}