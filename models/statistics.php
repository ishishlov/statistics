<?php
require_once 'models/main.php';

class StatisticsModel extends Main {

	const FIELDS = [
		0 => 'sezon',
		1 => 'is_home',
		2 => 'min',
		3 => 'z2',
		4 => 'b2',
		5 => 'z3',
		6 => 'b3',
		7 => 'z23',
		8 => 'b23',
		9 => 'qw',
		10 => 'we',
		11 => 'er',
		12 => 'rt',
		13 => 'ty',
		14 => 'yu',
		15 => 'ui',
		16 => 'io',
		17 => 'as',
		18 => 'sd',
		19 => 'df',
		20 => 'fg',
		21 => 'gh',
		22 => 'hj',
		23 => 'jk',
		24 => 'kl',
		25 => 'la',
	];
	
	public function save() {
		var_dump('Сохранение');exit;
	}

	public function get() {
		$sth = $this->_db->prepare('SELECT * FROM `statistic_games` WHERE game_id = ?');
		$sth->execute(['1058']);
		return $sth->fetch(PDO::FETCH_ASSOC);
	}
}