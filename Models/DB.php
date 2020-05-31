<?php

namespace Models;

use PDO;
use PDOException;

class DB {
	
	private $_db = null;

	const DEBUG_ENABLED = true;
	const CONFIG_PATH = __DIR__ . '/../../config.ini';

    public function getInstance() {
		if (!$this->_db) {
			$this->connect();
		}
		return $this->_db;
	}

	private function connect() {
        $config =  parse_ini_file(self::CONFIG_PATH, true);
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