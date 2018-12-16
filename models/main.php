<?php

require_once 'models/db.php';

class Main {
	
	protected $_db = null;

	public function __construct() {
		if (!$this->_db) {
			$this->_db = (new DB())->getInstance();
		}
	}

}