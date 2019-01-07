<?php
require_once 'models/main.php';
require_once 'models/cache.php';

class StatisticsModel extends Main {

	/** Статус протокола статистики - подтвержен */
	const STATUS_CONFIRMED = 1;
	/** Статус протокола статистики - не подтвержен */
	const STATUS_NOT_CONFIRMED = 2;

	/** Название таблицы статистики игроков */
	const TABLE_NAME_STATISTIC_PLAYERS = 'statistic_players';
	/** Название таблицы статистики игр */
	const TABLE_NAME_STATISTIC_GAMES = 'statistic_games';

	const CACHE_KEY_SEASONS_STATISTIC = 'seasonsStatistic';
	const CACHE_KEY_GAMES_STATISTIC = 'gamesStatistic';
	const CACHE_KEY_PLAYERS_STATISTIC = 'playersStatistic';

	const CACHE_KEY_SEASONS = 'seasons';

	const FIELDS = [
		0 => '`game_id`',
		1 => '`dt`',
		2 => '`tournament_id`',
		3 => '`team_id`',
		4 => '`player_id`',
		5 => '`season_id`',
		6 => '`venue`',
		7 => '`min`',
		8 => '`two_point_made`',
		9 => '`two_point_throw`',
		10 => '`three_point_made`',
		11 => '`three_point_throw`',
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
		24 => '`plus_minus`',
		25 => '`points_scored`',
		26 => '`games`',
		27 => '`gs`',
		28 => '`score`',
		29 => '`status`'
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
		self::FIELDS[28],
		self::FIELDS[29]
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

	public function getSeasonsStatistic($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(self::CACHE_KEY_SEASONS_STATISTIC, $seasonId, $tournamentIds);
		if (!$res) {
			$tournamentIdsString = implode(',', $tournamentIds);
			$sth = $this->_db->prepare(
				'SELECT
					MAX(sp.`two_point_made`) AS max_two_point_made,
					MAX(sp.`two_point_throw`) AS max_two_point_throw,
					MAX(ROUND(sp.`two_point_made` * 100 / sp.`two_point_throw`, 1)) AS max_two_point_percent,
					MAX(sp.`three_point_made`) AS max_three_point_made,
					MAX(sp.`three_point_throw`) AS max_three_point_throw,
					MAX(ROUND(sp.`three_point_made` * 100 / sp.`three_point_throw`, 1)) AS max_three_point_percent,
					MAX(sp.`two_point_made` + sp.`three_point_made`) AS max_two_three_point_made,
					MAX(sp.`two_point_throw` + sp.`three_point_throw`) AS max_two_three_point_throw,
					MAX(ROUND((sp.`two_point_made` + sp.`three_point_made`) * 100 / (sp.`two_point_throw` + sp.`three_point_throw`), 1)) AS max_two_three_point_percent,
					MAX(sp.free_made) AS max_free_made,
					MAX(sp.free_throw) AS max_free_throw,
					MAX(ROUND(sp.free_made * 100 / sp.free_throw)) AS max_free_percent,
					MAX(sp.offensive_rebound) AS max_offensive_rebound,
					MAX(sp.deffensive_rebound) AS max_deffensive_rebound,
					MAX(sp.offensive_rebound + sp.deffensive_rebound) AS max_sum_rebound,
					MAX(sp.assists) AS max_assists,
					MAX(sp.commited_foul) AS max_commited_foul,
					MAX(sp.recieved_foul) AS max_recieved_foul,
					MAX(sp.turnover) AS max_turnover,
					MIN(sp.turnover) AS min_turnover,
					MAX(sp.steal) AS max_steal,
					MAX(sp.in_fawor) AS max_in_fawor,
					MAX(sp.`against`) AS max_against,
					MAX(sp.effectiveness) AS max_effectiveness,
					MAX(sp.points_scored) AS max_points_scored,
					MAX(sp.`plus_minus`) AS max_plus_minus,
					MIN(sp.`plus_minus`) AS min_plus_minus
				FROM statistic_games sg 
				JOIN statistic_players sp ON sp.game_id = sg.game_id
				WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?'
			);
			$sth->execute([$seasonId]);
			$res = $sth->fetch(PDO::FETCH_ASSOC);

			Cache::setStatistic(self::CACHE_KEY_SEASONS_STATISTIC, $res, $seasonId, $tournamentIds);
		}
		return $res;
	}

	public function getGamesStatistic($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(self::CACHE_KEY_GAMES_STATISTIC, $seasonId, $tournamentIds);
		if (!$res) {
			$tournamentIdsString = implode(',', $tournamentIds);
			$sth = $this->_db->prepare(
				'SELECT sg.game_id, DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt, tr.`name` AS tournament, tm.logo_url, tm.`name` AS opponent,  IF(sg.venue = 1, "дома", "в гостях") AS venue, sg.score
				FROM `statistic_games` sg
				JOIN tournaments tr ON tr.tournament_id = sg.tournament_id
				JOIN teams tm ON tm.team_id = sg.team_id
				WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
				ORDER BY sg.dt DESC'
			);
			$sth->execute([$seasonId]);
			$res = $sth->fetchAll(PDO::FETCH_ASSOC);

			Cache::setStatistic(self::CACHE_KEY_GAMES_STATISTIC, $res, $seasonId, $tournamentIds);
		}
		return $res;
	}

	public function getPlayersStatistic($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(self::CACHE_KEY_PLAYERS_STATISTIC, $seasonId, $tournamentIds);
		if (!$res) {
			$tournamentIdsString = implode(',', $tournamentIds);
			$sth = $this->_db->prepare(
				'SELECT sp.player_id, p.number, p.name, p.surname, DATE_FORMAT(p.birthdate , "%d.%m.%Y") AS birthdate, c.logo_src, c.alpha, c.name AS country, gp.name AS position, p.height, p.weight
					FROM statistic_games sg
					JOIN statistic_players sp ON sp.game_id = sg.game_id
					JOIN players p ON p.player_id = sp.player_id
					LEFT JOIN game_positions gp ON gp.game_position_id = p.game_position_id
					LEFT JOIN countries c ON c.country_id = p.country_id
					WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
					GROUP BY sp.player_id
					ORDER BY p.number ASC'
			);
			$sth->execute([$seasonId]);
			$res = $sth->fetchAll(PDO::FETCH_ASSOC);

			Cache::setStatistic(self::CACHE_KEY_PLAYERS_STATISTIC, $res, $seasonId, $tournamentIds);
		}

		return $res;
	}

	public function getAllSeasons() {
		$res = Cache::getValue(self::CACHE_KEY_SEASONS);
		if (!$res) {
			$res = [];
			$sth = $this->_db->prepare('SELECT season_id FROM statistic_games WHERE status = ? GROUP BY season_id');
			$sth->execute([self::STATUS_CONFIRMED]);
			$seasonIds = $sth->fetchAll(PDO::FETCH_COLUMN);
			if (is_array($seasonIds)) {
				$sth = $this->_db->prepare('SELECT season_id, name 
											FROM seasons 
											WHERE season_id IN (' . implode(', ', $seasonIds) . ')
											ORDER BY season_id DESC');
				$sth->execute();
				$res = $sth->fetchAll(PDO::FETCH_ASSOC);
			}

			Cache::setValue(self::CACHE_KEY_SEASONS, $res);
		}

		return $res;
	}
	
	public function getTournaments() {
		$sth = $this->_db->prepare('SELECT tournament_id, name FROM tournaments');
		$sth->execute();
		return $sth->fetchAll(PDO::FETCH_ASSOC);
	}
	

	/**
	 * Получить данные по неподтвержденному протоколу
	 * 
	 * @return array
	 */
	public function getNotConfirmedGameIds() {
		$sth = $this->_db->prepare('
			SELECT game_id
			FROM `statistic_games` 
			WHERE status = ?');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
		return $sth->fetchAll(PDO::FETCH_COLUMN);
	}

	public function getNotConfirmedSeasonsStatistic() {
		$res = [];
		$sth = $this->_db->prepare('
			SELECT
				MAX(sp.`two_point_made`) AS max_two_point_made,
				MAX(sp.`two_point_throw`) AS max_two_point_throw,
				MAX(ROUND(sp.`two_point_made` * 100 / sp.`two_point_throw`, 1)) AS max_two_point_percent,
				MAX(sp.`three_point_made`) AS max_three_point_made,
				MAX(sp.`three_point_throw`) AS max_three_point_throw,
				MAX(ROUND(sp.`three_point_made` * 100 / sp.`three_point_throw`, 1)) AS max_three_point_percent,
				MAX(sp.`two_point_made` + sp.`three_point_made`) AS max_two_three_point_made,
				MAX(sp.`two_point_throw` + sp.`three_point_throw`) AS max_two_three_point_throw,
				MAX(ROUND((sp.`two_point_made` + sp.`three_point_made`) * 100 / (sp.`two_point_throw` + sp.`three_point_throw`), 1)) AS max_two_three_point_percent,
				MAX(sp.free_made) AS max_free_made,
				MAX(sp.free_throw) AS max_free_throw,
				MAX(ROUND(sp.free_made * 100 / sp.free_throw)) AS max_free_percent,
				MAX(sp.offensive_rebound) AS max_offensive_rebound,
				MAX(sp.deffensive_rebound) AS max_deffensive_rebound,
				MAX(sp.offensive_rebound + sp.deffensive_rebound) AS max_sum_rebound,
				MAX(sp.assists) AS max_assists,
				MAX(sp.commited_foul) AS max_commited_foul,
				MAX(sp.recieved_foul) AS max_recieved_foul,
				MAX(sp.turnover) AS max_turnover,
				MIN(sp.turnover) AS min_turnover,
				MAX(sp.steal) AS max_steal,
				MAX(sp.in_fawor) AS max_in_fawor,
				MAX(sp.`against`) AS max_against,
				MAX(sp.effectiveness) AS max_effectiveness,
				MAX(sp.points_scored) AS max_points_scored,
				MAX(sp.`plus_minus`) AS max_plus_minus,
				MIN(sp.`plus_minus`) AS min_plus_minus
			FROM statistic_games sg 
			JOIN statistic_players sp ON sp.game_id = sg.game_id
			WHERE sg.status = ?
		');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
		$data = $sth->fetch(PDO::FETCH_ASSOC);
		if ($data['max_two_point_made']) {
			$res = $data;
		}
		return $res;
	}

	/**
	 * Подтверждение протокола матча
	 * 
	 * @return bool
	 */
	public function confirmedProtocol() {
		$res = false;
		$gameIds = $this->getNotConfirmedGameIds();
		if ($gameIds) {
			$gameIdsString = implode(', ', $gameIds);
			$stmt = $this->_db->prepare('UPDATE ' . self::TABLE_NAME_STATISTIC_GAMES . ' SET `status` = ? WHERE `game_id` IN(' . $gameIdsString . ')');
			$res = $stmt->execute([self::STATUS_CONFIRMED]);
		}
		if ($res) {
			Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS_STATISTIC);
			Cache::deleteValue(StatisticsModel::CACHE_KEY_GAMES_STATISTIC);
			Cache::deleteValue(StatisticsModel::CACHE_KEY_PLAYERS_STATISTIC);
			Cache::deleteValue(StatisticsModel::CACHE_KEY_SEASONS);
		}
		return $res;
	}

	/**
	 * Удаление неподтвержденного протокола матча
	 * 
	 * @return bool
	 */
	public function deleteNotConfirmedProtocol() {
		$gameIds = $this->getNotConfirmedGameIds();
		if ($gameIds) {
			$gameIdsString = implode(', ', $gameIds);
			$stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME_STATISTIC_PLAYERS. ' WHERE `game_id` IN(' . $gameIdsString . ')');
			$res1 = $stmt->execute();
			$stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME_STATISTIC_GAMES . ' WHERE `game_id` IN(' . $gameIdsString . ')');
			$res2 = $stmt->execute();
			return $res1 && $res2;
		}
		return true;
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

		// убираем дублирование
		$finishStatisticGame = [];
		if ($statisticGame) {
			$gameIds = [];
			foreach ($statisticGame as $key => $value) {
				if (!in_array($value[self::FIELDS[0]], $gameIds)) {
					$value[self::FIELDS[1]] = date('Y-m-d', strtotime($value[self::FIELDS[1]]));
					$finishStatisticGame[] = $value;
					$gameIds[] = (int) $value[self::FIELDS[0]];
				}
			}
		}

		return [
			'statisticGame'		=> $finishStatisticGame,
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