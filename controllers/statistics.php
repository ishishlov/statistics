<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';

class Statistics extends Common {
	
	private $_model = null;
	
	public function __construct() {
		$this->_model = new StatisticsModel();
	}
	
	public function save() {
		var_dump('Сохранение');exit;
	}

	public function get() {
		$data = $this->_model->get();
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
		exit;
	}
}