<?php
require_once 'models/main.php';

class StatisticsModel extends Main {
	
	public function save() {
		var_dump('Сохранение');exit;
	}

	public function get() {
		$sth = $this->_db->prepare('SELECT * FROM `statistic_games` WHERE game_id = ?');
		$sth->execute(['1058']);
		return $sth->fetch(PDO::FETCH_ASSOC);
	}
}