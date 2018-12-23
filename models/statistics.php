<?php
require_once 'models/main.php';

class StatisticsModel extends Main {

	/** Статус протокола статистики - подтвержен */
	const STATUS_CONFIRMED = 1;
	/** Статус протокола статистики - не подтвержен */
	const STATUS_NOT_CONFIRMED = 2;

	/** Название таблицы статистики игроков */
	const TABLE_NAME_STATISTIC_PLAYERS = 'statistic_players';
	/** Название таблицы статистики игр */
	const TABLE_NAME_STATISTIC_GAMES = 'statistic_games';
	
	const FIELDS = [
		0 => '`game_id`',
		1 => '`dt`',
		2 => '`tournament_id`',
		3 => '`team_id`',
		4 => '`player_id`',
		5 => '`season_id`',
		6 => '`venue`',
		7 => '`min`',
		8 => '`two-point_made`',
		9 => '`two-point_throw`',
		10 => '`three-point_made`',
		11 => '`three-point_throw`',
		12 => '`free_made`',
		13 => '`free_throw`',
		14 => '`offensive_rebound`',
		15 => '`deffensive_rebound`',
		16 => '`assists`',
		17 => '`commited_foul`',
		18 => '`recieved_foul`',
		19 => '`turnover`',
		20 => '`steal`',
		21 => '`in_fawor`',
		22 => '`against`',
		23 => '`effectiveness`',
		24 => '`plus-minus`',
		25 => '`points_scored`',
		26 => '`games`',
		27 => '`gs`',
		28 => '`status`'
	];

	const FIELD_FOR_STATICTIC_PLAYER = [
		self::FIELDS[4],
		self::FIELDS[0],
		self::FIELDS[7],
		self::FIELDS[8],
		self::FIELDS[9],
		self::FIELDS[10],
		self::FIELDS[11],
		self::FIELDS[12],
		self::FIELDS[13],
		self::FIELDS[14],
		self::FIELDS[15],
		self::FIELDS[16],
		self::FIELDS[17],
		self::FIELDS[18],
		self::FIELDS[19],
		self::FIELDS[20],
		self::FIELDS[21],
		self::FIELDS[22],
		self::FIELDS[23],
		self::FIELDS[24],
		self::FIELDS[25],
		self::FIELDS[26],
		self::FIELDS[27]
	];

	const FIELD_FOR_STATICTIC_GAME = [
		self::FIELDS[0],
		self::FIELDS[1],
		self::FIELDS[2],
		self::FIELDS[3],
		self::FIELDS[6],
		self::FIELDS[5],
		self::FIELDS[28]
	];
	
	public function save($data) {
		$statisticGameAndPlayer = $this->_getDataForStaticticGameAndPlayer($data);
		$res = $this->_saveStaticticPlayer($statisticGameAndPlayer['statisticPlayer']);
		if ($res) {
			$res = $this->_saveStaticticGame($statisticGameAndPlayer['statisticGame']);
		}
		return $res;
	}

	public function getById($gameId) {
		$statistic = [];
		$dataDB = $this->_getFromDB($gameId);
		if ($dataDB) {
			$statistic = $this->_getCalculateStatistic($dataDB);
		}
		return $statistic;
	}

	private function _getDataForStaticticGameAndPlayer($data) {
		$statisticGame = [];
		$statisticPlayer = [];
		foreach ($data as $key => $statistics) {
			foreach ($statistics as $title => $statistic) {
				if (in_array($title, self::FIELD_FOR_STATICTIC_GAME)) {
					$statisticGame[$key][$title] = $statistic;
				}

				if (in_array($title, self::FIELD_FOR_STATICTIC_PLAYER)) {
					$statisticPlayer[$key][$title] = $statistic;
				}
			}
		}
		return [
			'statisticGame'		=> [$statisticGame[0]],
			'statisticPlayer'	=> $statisticPlayer
		];
	}

	private function _getFromDB($gameId) {
		$sth = $this->_db->prepare('SELECT * FROM `statistic_games` WHERE game_id = ?');
		$sth->execute([$gameId]);
		return $sth->fetch(PDO::FETCH_ASSOC);
	}

	private function _getCalculateStatistic($dataDB) {
		
	}

	private function _saveStaticticGame($data) {
		return $this->insert(self::TABLE_NAME_STATISTIC_GAMES, $data);
	}

	private function _saveStaticticPlayer($data) {
		return $this->insert(self::TABLE_NAME_STATISTIC_PLAYERS, $data);
	}
}