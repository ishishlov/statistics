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

	public function getBySeasonIdAndTournamentId($seasonId, $tournamentId) {
		$sth = $this->_db->prepare(
			'SELECT
				SUM(sp.`two-point_made`) AS "two-point_made",
				SUM(sp.`two-point_throw`) AS "two-point_throw",
				SUM(sp.`three-point_made`) AS "three-point_made",
				SUM(sp.`three-point_throw`) AS "three-point_throw",
				SUM(sp.free_made) AS "free_made",
				SUM(sp.free_throw) AS "free_throw",
				SUM(sp.offensive_rebound) AS "offensive_rebound",
				SUM(sp.deffensive_rebound) AS "deffensive_rebound",
				SUM(sp.assists) AS "assists",
				SUM(sp.commited_foul) AS "commited_foul",
				SUM(sp.recieved_foul) AS "recieved_foul",
				MAX(sp.turnover) AS "max_turnover",
				MIN(sp.turnover) AS "min_turnover",
				SUM(sp.steal) AS "steal",
				SUM(sp.in_fawor) AS "in_fawor",
				SUM(sp.`against`) AS "against",
				SUM(sp.effectiveness) AS "effectiveness",
				SUM(sp.points_scored) AS "points_scored",
				MAX(sp.op) AS "max_op",
				MIN(sp.op) AS "min_op",
				MAX(sp.`plus-minus`) AS "max_plus-minus",
				MIN(sp.`plus-minus`) AS "min_plus-minus",
				MAX(sp.pvk) AS "max_pvk",
				MIN(sp.pvk) AS "min_pvk",
				MAX(sp.bvk) AS "max_bvk",
				MIN(sp.bvk) AS "min_bvk"
			FROM statistic_players sp 
			JOIN statistic_games sg ON sp.game_id = sg.game_id
			WHERE sg.season_id = ? AND tournament_id = ?'
		);
		$sth->execute([$seasonId, $tournamentId]);
		return $sth->fetch(PDO::FETCH_ASSOC);
	}

	/**
	 * Добавление к массиву сырых данных вычисляемых полей
	 * 
	 * @param array $data -массив сырых данных из бд
	 * @return array
	 */
	public function addCalculateCommandStatistics($data) {
		$data['two-three-point_made'] = (int)$data['two-point_made'] + (int)$data['three-point_made'];
		$data['two-three-point_throw'] = (int)$data['two-point_throw'] + (int)$data['three-point_throw'];
		$data['two-point_percent'] = round((int)$data['two-point_made'] * 100 / (int)$data['two-point_throw'], 1);
		$data['three-point_percent'] = round((int)$data['three-point_made'] * 100 / (int)$data['three-point_throw'], 1);
		$data['two-three-point_percent'] = round((int)$data['two-three-point_made'] * 100 / (int)$data['two-three-point_throw'], 1);
		$data['free_percent'] = round((int)$data['free_made'] * 100 / (int)$data['free_throw'], 1);
		return $data;
	}

	/**
	 * Получить данные по неподтвержденному протоколу
	 * 
	 * @return array
	 */
	public function getNotConfirmedProtocolData() {
		$sth = $this->_db->prepare('
			SELECT
				game_id
			FROM `statistic_games` 
			
			WHERE status = ?');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
		return $sth->fetch(PDO::FETCH_ASSOC);
	}

	/**
	 * Подтверждение протокола матча
	 * 
	 * @return bool
	 */
	public function confirmedProtocol() {
		$stmt = $this->_db->prepare('UPDATE ' . self::TABLE_NAME_STATISTIC_GAMES . ' SET `status` = ? WHERE `status` = ?');
		return $stmt->execute([self::STATUS_CONFIRMED, self::STATUS_NOT_CONFIRMED]);
	}

	/**
	 * Удаление неподтвержденного протокола матча
	 * 
	 * @return bool
	 */
	public function deleteNotConfirmedProtocol($gameId) {
		$stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME_STATISTIC_PLAYERS. ' WHERE `game_id` = ?');
		$res1 = $stmt->execute([$gameId]);
		$stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME_STATISTIC_GAMES . ' WHERE `game_id` = ?');
		$res2 = $stmt->execute([$gameId]);
		return $res1 && $res2;
	}

	/**
	 * Получить массивы данных по статистике игры и статистике игроков
	 * 
	 * @param array $data
	 * @return array
	 */
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