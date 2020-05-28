<?php

namespace Models;

use PDO;

class DB {
	
	private $_db = null;

	const DEBUG_ENABLED = true;

    public function getInstance() {
		if (!$this->_db) {
			$this->connect();
		}
		return $this->_db;
	}

	private function connect() {
        $config =  parse_ini_file('../config.ini', true);
        $port = $config['SQL']['port'] ? ';port=' . $config['SQL']['port'] : '';

	    $debug = self::DEBUG_ENABLED ? [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION] : [];
		try {
			$this->_db = new PDO(
				'mysql:dbname=' . $config['SQL']['name'] . ';host=' . $config['SQL']['host'] . $port,
                $config['SQL']['login'],
                $config['SQL']['password'],
                $debug
			);
			$this->_db->query("SET NAMES 'utf8'");
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}
	
}