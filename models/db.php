<?php

class DB {
	
	private $_db = null;
	private $_host = '127.0.0.1:3306';
	private $_name = 'statistics';
	private $_login = 'root';
	private $_password = '';

	public function getInstance() {
		if (!$this->_db) {
			$this->connect();
		}
		return $this->_db;
	}

	private function connect() {
		try {
			$this->_db = new PDO(
				'mysql:dbname=' . $this->_name . ';host=' . $this->_host,
				$this->_login,
				$this->_password
			);
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}
	
}