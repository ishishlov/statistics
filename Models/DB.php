<?php

namespace Models;

use PDO;

class DB {
	
	private $_db = null;
	private $_host = '127.0.0.1';
	private $_port = '3306';
	private $_name = 'statistics';
	private $_login = 'root';
	private $_password = '';

	const DEBUG_ENABLED = true;

	public function getInstance() {
		if (!$this->_db) {
			$this->connect();
		}
		return $this->_db;
	}

	private function connect() {
	    $debug = self::DEBUG_ENABLED ? [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION] : [];
		try {
			$this->_db = new PDO(
				'mysql:dbname=' . $this->_name . ';host=' . $this->_host . ';port=' . $this->_port,
				$this->_login,
				$this->_password,
                $debug
			);
			$this->_db->query("SET NAMES 'utf8'");
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}
	
}