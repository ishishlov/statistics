<?php
require_once 'models/main.php';

class StatisticsModel extends Main {

	const FIELDS = [
		0 => 'game_id',
		1 => 'dt',
		2 => 'tournament_id',
		3 => 'team_id',
		4 => 'player_id',
		5 => 'season_id',
		6 => 'venue',
		7 => 'min',
		8 => 'two-point_made',
		9 => 'two-point_throw',
		10 => 'three-point_made',
		11 => 'three-point_throw',
		12 => 'free_made',
		13 => 'free_throw',
		14 => 'offensive_rebound',
		15 => 'deffensive_rebound',
		16 => 'assists',
		17 => 'commited_foul',
		18 => 'recieved _foul',
		19 => 'turnover',
		20 => 'steal',
		21 => 'in_fawor',
		22 => 'against',
		23 => 'effectiveness',
		24 => 'plus-minus',
		25 => 'points_scored',
		26 => 'games',
		27 => 'gs',
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