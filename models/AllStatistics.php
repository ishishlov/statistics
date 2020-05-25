<?php
require_once 'models/Main.php';
require_once 'models/Cache.php';

class AllStatistics extends Main {

	/** Статус протокола статистики - подтвержен */
	const STATUS_CONFIRMED = 1;
	/** Статус протокола статистики - не подтвержен */
	const STATUS_NOT_CONFIRMED = 2;

	/** Название таблицы статистики игроков */
	const TABLE_NAME_STATISTIC_PLAYERS      = 'statistic_players';
	/** Название таблицы статистики игр */
	const TABLE_NAME_STATISTIC_GAMES        = 'statistic_games';
    /** Название таблицы игр истории */
    const TABLE_NAME_HISTORY_GAMES          = 'history';

	/** Выбор по всем сезонам */
	const ALL_SEASONS = 999;

	const FIELD_GAME_ID = 0;
	const FIELD_DATE = 1;
	const FIELD_TOURNAMENT_ID = 2;
	const FIELD_TEAM_ID = 3;
	const FIELD_PLAYER_ID = 4;
	const FIELD_SEASON_ID = 5;
	const FIELD_VENUE = 6;
	const FIELD_SECONDS = 7;
	const FIELD_TWO_POINT_MADE = 8;
	const FIELD_TWO_POINT_THROW = 9;
    const FIELD_THREE_POINT_MADE = 10;
    const FIELD_THREE_POINT_THROW = 11;
	const FIELD_FREE_MADE = 12;
	const FIELD_FREE_THROW = 13;
	const FIELD_OFFENSIVE_REBOUND = 14;
	const FIELD_DEFFENSIVE_REBOUND = 15;
	const FIELD_ASSISTS = 16;
	const FIELD_COMMITED_FOUL = 17;
	const FIELD_RECIEVED_FOUL = 18;
	const FIELD_TURNOVER = 19;
	const FIELD_STEAL = 20;
	const FIELD_IN_FAWOR = 21;
	const FIELD_AGAINST = 22;
	const FIELD_EFFECTIVENESS = 23;
	const FIELD_PLUS_MINUS = 24;
	const FIELD_POINTS_SCORED = 25;
	const FIELD_GAMES = 26;
	const FIELD_GS = 27;
	const FIELD_SCORE = 28;
	const FIELD_STATUS = 29;

	const FIELDS = [
		self::FIELD_GAME_ID => '`game_id`',
        self::FIELD_DATE => '`dt`',
        self::FIELD_TOURNAMENT_ID => '`tournament_id`',
        self::FIELD_TEAM_ID => '`team_id`',
        self::FIELD_PLAYER_ID => '`player_id`',
        self::FIELD_SEASON_ID => '`season_id`',
        self::FIELD_VENUE => '`venue`',
        self::FIELD_SECONDS => '`seconds`',
        self::FIELD_TWO_POINT_MADE => '`two_point_made`',
        self::FIELD_TWO_POINT_THROW => '`two_point_throw`',
        self::FIELD_THREE_POINT_MADE => '`three_point_made`',
        self::FIELD_THREE_POINT_THROW => '`three_point_throw`',
        self::FIELD_FREE_MADE => '`free_made`',
        self::FIELD_FREE_THROW => '`free_throw`',
        self::FIELD_OFFENSIVE_REBOUND => '`offensive_rebound`',
        self::FIELD_DEFFENSIVE_REBOUND => '`deffensive_rebound`',
        self::FIELD_ASSISTS => '`assists`',
        self::FIELD_COMMITED_FOUL => '`commited_foul`',
        self::FIELD_RECIEVED_FOUL => '`recieved_foul`',
        self::FIELD_TURNOVER => '`turnover`',
        self::FIELD_STEAL => '`steal`',
        self::FIELD_IN_FAWOR => '`in_fawor`',
        self::FIELD_AGAINST => '`against`',
        self::FIELD_EFFECTIVENESS => '`effectiveness`',
        self::FIELD_PLUS_MINUS => '`plus_minus`',
        self::FIELD_POINTS_SCORED => '`points_scored`',
        self::FIELD_GAMES => '`games`',
        self::FIELD_GS => '`gs`',
        self::FIELD_SCORE => '`score`',
        self::FIELD_STATUS => '`status`'
	];

	const FIELD_FOR_STATICTIC_PLAYER = [
		self::FIELDS[self::FIELD_PLAYER_ID],
		self::FIELDS[self::FIELD_GAME_ID],
		self::FIELDS[self::FIELD_SECONDS],
		self::FIELDS[self::FIELD_TWO_POINT_MADE],
		self::FIELDS[self::FIELD_TWO_POINT_THROW],
		self::FIELDS[self::FIELD_THREE_POINT_MADE],
		self::FIELDS[self::FIELD_THREE_POINT_THROW],
		self::FIELDS[self::FIELD_FREE_MADE],
		self::FIELDS[self::FIELD_FREE_THROW],
		self::FIELDS[self::FIELD_OFFENSIVE_REBOUND],
		self::FIELDS[self::FIELD_DEFFENSIVE_REBOUND],
		self::FIELDS[self::FIELD_ASSISTS],
		self::FIELDS[self::FIELD_COMMITED_FOUL],
		self::FIELDS[self::FIELD_RECIEVED_FOUL],
		self::FIELDS[self::FIELD_TURNOVER],
		self::FIELDS[self::FIELD_STEAL],
		self::FIELDS[self::FIELD_IN_FAWOR],
		self::FIELDS[self::FIELD_AGAINST],
		self::FIELDS[self::FIELD_EFFECTIVENESS],
		self::FIELDS[self::FIELD_PLUS_MINUS],
		self::FIELDS[self::FIELD_POINTS_SCORED],
		self::FIELDS[self::FIELD_GAMES],
		self::FIELDS[self::FIELD_GS]
	];

	const FIELD_FOR_STATICTIC_GAME = [
		self::FIELDS[self::FIELD_GAME_ID],
		self::FIELDS[self::FIELD_DATE],
		self::FIELDS[self::FIELD_TOURNAMENT_ID],
		self::FIELDS[self::FIELD_TEAM_ID],
		self::FIELDS[self::FIELD_VENUE],
		self::FIELDS[self::FIELD_SEASON_ID],
		self::FIELDS[self::FIELD_SCORE],
		self::FIELDS[self::FIELD_STATUS]
	];

	public function save($data) {
		$statisticGameAndPlayer = $this->_getDataForStaticticGameAndPlayer($data);
		$res = $this->_saveStaticticPlayer($statisticGameAndPlayer['statisticPlayer']);
		if ($res) {
			$res = $this->_saveStaticticGame($statisticGameAndPlayer['statisticGame']);
		}

		return $res;
	}

	public function getGameIds($gameIds)
    {
        $gameIdsString = implode(',', $gameIds);
        $sth = $this->_db->prepare('SELECT game_id FROM statistic_games WHERE game_id IN (' . $gameIdsString . ')');
        $sth->execute();

        $res = $sth->fetchAll(PDO::FETCH_ASSOC);

        $gameId = [];
        if ($res) {
            foreach ($res as $id) {
                $gameId[] = (int) $id['game_id'];
            }
        }

        return $gameId;
    }

    public function getTeams() {
        $sth = $this->_db->prepare(
            'SELECT
                team_id,
                `name`
			FROM teams
            ORDER BY `name` ASC'
        );
        $sth->execute();
        return $sth->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getSeasonsStatistic($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(Cache::CACHE_KEY_SEASONS_STATISTIC, $seasonId, $tournamentIds);
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

			Cache::setStatistic(Cache::CACHE_KEY_SEASONS_STATISTIC, $res, $seasonId, $tournamentIds);
		}
		return $res;
	}

	public function getGamesData($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(Cache::CACHE_KEY_GAMES_STATISTIC, $seasonId, $tournamentIds);
		if (!$res) {
			$tournamentIdsString = implode(',', $tournamentIds);
			$sth = $this->_db->prepare(
				'SELECT
				    sg.game_id,
                    DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt,
                    tr.`name` AS tournament,
                    tm.logo_url,
                    tm.`name` AS opponent,
                    IF(sg.venue = 1, "дома", "в гостях") AS venue,
                    sg.score,
                    tm.url
				FROM `statistic_games` sg
				JOIN tournaments tr ON tr.tournament_id = sg.tournament_id
				JOIN teams tm ON tm.team_id = sg.team_id
				WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
				ORDER BY sg.dt DESC'
			);
			$sth->execute([$seasonId]);
			$res = $sth->fetchAll(PDO::FETCH_ASSOC);
			Cache::setStatistic(Cache::CACHE_KEY_GAMES_STATISTIC, $res, $seasonId, $tournamentIds);
		}
		return $res;
	}

	public function getPlayers($seasonId, $tournamentIds) {
		$res = Cache::getStatistic(Cache::CACHE_KEY_PLAYERS_STATISTIC, $seasonId, $tournamentIds);
		if (!$res) {
			$tournamentIdsString = implode(',', $tournamentIds);
			$sth = $this->_db->prepare(
				'SELECT sp.player_id,
                    p.number,
                    p.name,
                    p.surname,
                    DATE_FORMAT(p.birthdate , "%d.%m.%Y") AS birthdate,
                    c.logo_src,
                    c.alpha,
                    c.name AS country,
                    gp.name AS position,
                    p.height,
                    p.weight,
                    p.avatar_src
                FROM statistic_games sg
                JOIN statistic_players sp ON sp.game_id = sg.game_id
                JOIN players p ON p.player_id = sp.player_id
                JOIN game_positions gp ON gp.game_position_id = p.game_position_id
                JOIN countries c ON c.country_id = p.country_id
                WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
                GROUP BY sp.player_id
                ORDER BY p.number ASC'
			);
			$sth->execute([$seasonId]);
			$res = $sth->fetchAll(PDO::FETCH_ASSOC);

			Cache::setStatistic(Cache::CACHE_KEY_PLAYERS_STATISTIC, $res, $seasonId, $tournamentIds);
		}

		return $res;
	}

    public function getPlayer($playerId) {
        $res = Cache::getInfo(Cache::CACHE_KEY_PLAYER_INFO, $playerId);
        if (!$res) {
            $sth = $this->_db->prepare(
                'SELECT
                    p.player_id,
                    p.number,
                    p.name,
                    p.surname,
                    DATE_FORMAT(p.birthdate , "%d.%m.%Y") AS birthdate,
                    gp.name AS position,
                    p.height,
                    p.weight,
                    avatar_src
                FROM players p
                JOIN game_positions gp ON gp.game_position_id = p.game_position_id
                WHERE p.player_id = ?'
            );
            $sth->execute([$playerId]);
            $res = $sth->fetch(PDO::FETCH_ASSOC);

            Cache::setInfo(Cache::CACHE_KEY_PLAYER_INFO, $res, $playerId);
        }

        return $res;
    }

    public function getPlayerStatistic($playerId, $seasonId, $tournamentIds) {
        $res = Cache::getPlayerStatistic(Cache::CACHE_KEY_PLAYER_STATISTIC, $playerId, $seasonId, $tournamentIds);
        if (!$res) {
            $tournamentIdsString = implode(',', $tournamentIds);
            $sth = $this->_db->prepare(
                'SELECT
                    MAX(sp.`seconds`) AS MAX_seconds,
                    MAX(sp.`two_point_made`) AS MAX_two_point_made,
					MAX(sp.`two_point_throw`) AS MAX_two_point_throw,
					MAX(sp.`three_point_made`) AS MAX_three_point_made,
					MAX(sp.`three_point_throw`) AS MAX_three_point_throw,
					MAX(sp.`two_point_made` + sp.`three_point_made`) AS MAX_two_three_point_made,
					MAX(sp.`two_point_throw` + sp.`three_point_throw`) AS MAX_two_three_point_throw,
					MAX(sp.free_made) AS MAX_free_made,
					MAX(sp.free_throw) AS MAX_free_throw,
					MAX(sp.offensive_rebound) AS MAX_offensive_rebound,
					MAX(sp.deffensive_rebound) AS MAX_deffensive_rebound,
					MAX(sp.offensive_rebound + sp.deffensive_rebound) AS MAX_sum_rebound,
					MAX(sp.assists) AS MAX_assists,
					MAX(sp.commited_foul) AS MAX_commited_foul,
					MAX(sp.recieved_foul) AS MAX_recieved_foul,
					MAX(sp.turnover) AS MAX_turnover,
					MAX(sp.steal) AS MAX_steal,
					MAX(sp.in_fawor) AS MAX_in_fawor,
					MAX(sp.`against`) AS MAX_against,
					MAX(sp.effectiveness) AS MAX_effectiveness,
					MAX(sp.points_scored) AS MAX_points_scored,
					MAX(sp.`plus_minus`) AS MAX_plus_minus,

                    SUM(sp.`seconds`) AS SUM_seconds,
                    SUM(sp.`two_point_made`) AS SUM_two_point_made,
					SUM(sp.`two_point_throw`) AS SUM_two_point_throw,
					SUM(sp.`three_point_made`) AS SUM_three_point_made,
					SUM(sp.`three_point_throw`) AS SUM_three_point_throw,
					SUM(sp.`two_point_made` + sp.`three_point_made`) AS SUM_two_three_point_made,
					SUM(sp.`two_point_throw` + sp.`three_point_throw`) AS SUM_two_three_point_throw,
					SUM(sp.free_made) AS SUM_free_made,
					SUM(sp.free_throw) AS SUM_free_throw,
					SUM(sp.offensive_rebound) AS SUM_offensive_rebound,
					SUM(sp.deffensive_rebound) AS SUM_deffensive_rebound,
					SUM(sp.offensive_rebound + sp.deffensive_rebound) AS SUM_sum_rebound,
					SUM(sp.assists) AS SUM_assists,
					SUM(sp.commited_foul) AS SUM_commited_foul,
					SUM(sp.recieved_foul) AS SUM_recieved_foul,
					SUM(sp.turnover) AS SUM_turnover,
					SUM(sp.steal) AS SUM_steal,
					SUM(sp.in_fawor) AS SUM_in_fawor,
					SUM(sp.`against`) AS SUM_against,
					SUM(sp.effectiveness) AS SUM_effectiveness,
					SUM(sp.points_scored) AS SUM_points_scored,
					SUM(sp.`plus_minus`) AS SUM_plus_minus,

                    ROUND(AVG(sp.`seconds`)) AS AVG_seconds,
					ROUND(AVG(sp.`two_point_made`)) AS AVG_two_point_made,
					ROUND(AVG(sp.`two_point_throw`)) AS AVG_two_point_throw,
					ROUND(AVG(sp.`three_point_made`)) AS AVG_three_point_made,
					ROUND(AVG(sp.`three_point_throw`)) AS AVG_three_point_throw,
					ROUND(AVG(sp.`two_point_made` + sp.`three_point_made`)) AS AVG_two_three_point_made,
					ROUND(AVG(sp.`two_point_throw` + sp.`three_point_throw`)) AS AVG_two_three_point_throw,
					ROUND(AVG(sp.free_made)) AS AVG_free_made,
					ROUND(AVG(sp.free_throw)) AS AVG_free_throw,
					ROUND(AVG(sp.offensive_rebound)) AS AVG_offensive_rebound,
					ROUND(AVG(sp.deffensive_rebound)) AS AVG_deffensive_rebound,
					ROUND(AVG(sp.offensive_rebound + sp.deffensive_rebound)) AS AVG_sum_rebound,
					ROUND(AVG(sp.assists)) AS AVG_assists,
					ROUND(AVG(sp.commited_foul)) AS AVG_commited_foul,
					ROUND(AVG(sp.recieved_foul)) AS AVG_recieved_foul,
					ROUND(AVG(sp.turnover)) AS AVG_turnover,
					ROUND(AVG(sp.steal)) AS AVG_steal,
					ROUND(AVG(sp.in_fawor)) AS AVG_in_fawor,
					ROUND(AVG(sp.`against`)) AS AVG_against,
					ROUND(AVG(sp.effectiveness)) AS AVG_effectiveness,
					ROUND(AVG(sp.points_scored)) AS AVG_points_scored,
					ROUND(AVG(sp.`plus_minus`)) AS AVG_plus_minus
				FROM statistic_games sg 
				JOIN statistic_players sp ON sp.game_id = sg.game_id
				WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ? AND sp.player_id = ?'
            );
            $sth->execute([$seasonId, $playerId]);
            $res = $sth->fetch(PDO::FETCH_ASSOC);

            $res['MAX_player_time'] = $this->getPlayerTime($res['MAX_seconds']);
            $res['SUM_player_time'] = $this->getPlayerTime($res['SUM_seconds']);
            $res['AVG_player_time'] = $this->getPlayerTime($res['AVG_seconds']);

            Cache::setPlayerStatistic(Cache::CACHE_KEY_PLAYER_STATISTIC, $res, $playerId, $seasonId, $tournamentIds);
        }

        return $res;
    }

    public function getPlayerGamesStatistic($playerId, $seasonId, $tournamentIds)
    {
        $res = Cache::getPlayerStatistic(Cache::CACHE_KEY_PLAYER_GAMES_STATISTIC, $playerId, $seasonId, $tournamentIds);
        if (!$res) {
            $tournamentIdsString = implode(',', $tournamentIds);
            $sth = $this->_db->prepare(
                'SELECT
					sg.game_id,
                    DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt,
                    sp.seconds,
					sp.`two_point_made`,
					sp.`two_point_throw`,
					sp.`three_point_made`,
					sp.`three_point_throw`,
					sp.`two_point_made` + sp.`three_point_made` AS two_three_point_made,
					sp.`two_point_throw` + sp.`three_point_throw` AS two_three_point_throw,
					sp.free_made,
					sp.free_throw,
					sp.offensive_rebound,
					sp.deffensive_rebound,
					sp.assists,
					sp.commited_foul,
					sp.recieved_foul,
					sp.turnover,
					sp.steal,
					sp.in_fawor,
					sp.`against`,
					sp.effectiveness,
					sp.points_scored,
					sp.`plus_minus`,
					sg.score,
					DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt,
					t.`name` AS team_name
				FROM statistic_games sg 
				JOIN statistic_players sp ON sp.game_id = sg.game_id
				JOIN teams t ON t.team_id = sg.team_id
				WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ? AND sp.player_id = ?
				ORDER BY sg.dt DESC'
            );
            $sth->execute([$seasonId, $playerId]);
            $res = $sth->fetchAll(PDO::FETCH_ASSOC);

            foreach ($res as &$game) {
                $game['player_time'] = $this->getPlayerTime($game['seconds']);
            }
            unset($game);

            Cache::setPlayerStatistic(Cache::CACHE_KEY_PLAYER_GAMES_STATISTIC, $res, $playerId, $seasonId, $tournamentIds);
        }

        return $res;
    }

	public function getGameInfo($gameId) {
		$res = Cache::getInfo(Cache::CACHE_KEY_PLAYER_STATISTIC, $gameId);
        if (!$res) {
            $sth = $this->_db->prepare(
				'SELECT
					p.player_id,
					p.`name`,
					p.`surname`,
					sp.seconds,
					sp.`two_point_made`,
					sp.`two_point_throw`,
					sp.`three_point_made`,
					sp.`three_point_throw`,
					sp.`two_point_made` + sp.`three_point_made` AS two_three_point_made,
					sp.`two_point_throw` + sp.`three_point_throw` AS two_three_point_throw,
					sp.free_made,
					sp.free_throw,
					sp.offensive_rebound,
					sp.deffensive_rebound,
					sp.assists,
					sp.commited_foul,
					sp.recieved_foul,
					sp.turnover,
					sp.steal,
					sp.in_fawor,
					sp.`against`,
					sp.effectiveness,
					sp.points_scored,
					sp.`plus_minus`,
					sg.score,
					DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt,
					t.`name` AS team_name
				FROM statistic_games sg 
				JOIN statistic_players sp ON sp.game_id = sg.game_id
				JOIN players p ON p.player_id = sp.player_id
				JOIN teams t ON t.team_id = sg.team_id
				WHERE sg.game_id = ?'
			);
            $sth->execute([$gameId]);
            $res['player'] = $sth->fetchAll(PDO::FETCH_ASSOC);

            $res['sum'] = $this->_getSumColumns($res['player']);
            $res['sum']['player_time'] = $this->getPlayerTime($res['sum']['seconds']);

            foreach ($res['player'] as &$game) {
                $game['player_time'] = $this->getPlayerTime($game['seconds']);
            }
            unset($game);

            Cache::setInfo(Cache::CACHE_KEY_PLAYER_STATISTIC, $res, $gameId);
        }

        return $res;
	}

	public function getGamesInfo() {
		$data = [];
		$gameIds = $this->getNotConfirmedGameIds();
		if ($gameIds && is_array($gameIds)) {
			$gameIds = array_unique($gameIds);
			foreach ($gameIds as $gameId) {
				$data[] = $this->getGameInfo($gameId);
			}
		}

		return $data;
	}
	
	public function getAllSeasons() {
		$res = Cache::getValue(Cache::CACHE_KEY_SEASONS);
		if (!$res) {
			$sth = $this->_db->prepare(
				'SELECT
					season_id,
					`name` 
				FROM seasons 
				ORDER BY season_id DESC');
			$sth->execute();
			$res = $sth->fetchAll(PDO::FETCH_ASSOC);

			Cache::setValue(Cache::CACHE_KEY_SEASONS, $res);
		}

		return $res;
	}

    public function getTournaments() {
        $res = Cache::getValue(Cache::CACHE_KEY_TOURNAMENTS);
        if (!$res) {
            $sth = $this->_db->prepare(
                'SELECT
                    tournament_id,
                    `name`
                FROM tournaments'
            );
            $sth->execute();
            $res = $sth->fetchAll(PDO::FETCH_ASSOC);

            Cache::setValue(Cache::CACHE_KEY_TOURNAMENTS, $res);
        }

        return $res;
	}

    public function getHistory($seasonId, $tournamentIds) {
        $res = Cache::getStatistic(Cache::CACHE_KEY_HISTORY, $seasonId, $tournamentIds);
        if (!$res) {
            $tournamentIdsString = implode(',', $tournamentIds);
            $sth = $this->_db->prepare(
                'SELECT
                    tm1.`name` AS team_name_one,
                    tm1.url AS team_url_one,
                    tm1.logo_url AS team_logo_url_one,
                    tm2.`name` AS team_name_two,
                    tm2.url AS team_url_two,
                    tm2.logo_url AS team_logo_url_two,
                    h.dt,
                    h.score_one,
                    h.score_two,
                    h.tournament_id,
                    h.season_id,
                    t.`name` AS tournament_name,
                    s.`name` AS season_name
                FROM history h
                JOIN teams tm1 ON tm1.team_id = h.team_id_one
                JOIN teams tm2 ON tm2.team_id = h.team_id_two
                JOIN tournaments t ON t.tournament_id = h.tournament_id
                JOIN seasons s ON s.season_id = h.season_id
                WHERE h.tournament_id IN (' . $tournamentIdsString . ') AND h.season_id = ?
                ORDER BY dt ASC'
            );
            $sth->execute([$seasonId]);
            $res = $sth->fetchAll(PDO::FETCH_ASSOC);

            Cache::setStatistic(Cache::CACHE_KEY_HISTORY, $res, $seasonId, $tournamentIds);
        }

        return $res;
    }

    public function getHistoryTeamsTotal($seasonId, $tournamentIds) {
        $res = Cache::getStatistic(Cache::CACHE_KEY_HISTORY, $seasonId, $tournamentIds);
        if (!$res) {
            $tournamentIdsString = implode(',', $tournamentIds);
            $sth = $this->_db->prepare(
                'SELECT
                  htt.number,
                  t.`name`,
                  htt.season_id,
                  htt.`two_point_made`,
                  htt.`two_point_throw`,
                  htt.`two_point_percent`,
                  htt.`three_point_made`,
                  htt.`three_point_throw`,
                  htt.`three_point_percent`,
                  htt.`two_three_point_made`,
                  htt.`two_three_point_throw`,
                  htt.`two_three_point_percent`,
                  htt.free_made,
                  htt.free_throw,
                  htt.free_percent,
                  htt.offensive_rebound,
                  htt.deffensive_rebound,
                  htt.sum_rebound,
                  htt.assists,
                  htt.commited_foul,
                  htt.recieved_foul,
                  htt.turnover,
                  htt.steal,
                  htt.in_fawor,
                  htt.`against`,
                  htt.effectiveness,
                  htt.points_scored,
                  htt.`plus_minus`
                FROM history_teams_total htt
                LEFT JOIN teams t ON t.team_id = htt.team_id
                WHERE htt.tournament_id IN (' . $tournamentIdsString . ') AND htt.season_id = ?
                ORDER BY htt.number ASC'
            );
            $sth->execute([$seasonId]);
            $res = $sth->fetchAll(PDO::FETCH_ASSOC);

            Cache::setStatistic(Cache::CACHE_KEY_PLAYER_GAMES_STATISTIC, $res, $seasonId, $tournamentIds);
        }

        return $res;
    }

    public function getHistoryRecords($seasonId, $tournamentIds) {
        $res = Cache::getStatistic(Cache::CACHE_KEY_RECORDS, $seasonId, $tournamentIds);
        if (!$res) {
            $gamesRecordData = $this->_getGamesRecordData($seasonId, $tournamentIds);
            $playersRecordData = $this->_getPlayersRecordData($seasonId, $tournamentIds);
            $res = $this->_getCalculateRecords($gamesRecordData, $playersRecordData);

            Cache::setStatistic(Cache::CACHE_KEY_RECORDS, $res, $seasonId, $tournamentIds);
        }

        return $res;
    }

    public function getHistoryTables($seasonId, $tournamentIds) {
		$seasonId = (int) $seasonId;
        $res = Cache::getStatistic(Cache::CACHE_KEY_TOTAL, $seasonId, $tournamentIds);
        if (!$res) {
			$seasonSql = ($seasonId === self::ALL_SEASONS) ? '' : 'AND sg.season_id = ' . $seasonId;
            $tournamentIdsString = implode(',', $tournamentIds);
            $sth = $this->_db->prepare(
                'SELECT
                    p.player_id,
                    p.`name`,
                    p.`surname`,
                    SUM(sp.`seconds`) AS seconds,
                    SUM(sp.`two_point_made`) AS two_point_made,
                    SUM(sp.`two_point_throw`) AS two_point_throw,
                    SUM(sp.`three_point_made`) AS three_point_made,
                    SUM(sp.`three_point_throw`) AS three_point_throw,
                    SUM(sp.`two_point_made` + sp.`three_point_made`) AS two_three_point_made,
                    SUM(sp.`two_point_throw` + sp.`three_point_throw`) AS two_three_point_throw,
                    SUM(sp.free_made) AS free_made,
                    SUM(sp.free_throw) AS free_throw,
                    SUM(sp.offensive_rebound) AS offensive_rebound,
                    SUM(sp.deffensive_rebound) AS deffensive_rebound,
                    SUM(sp.offensive_rebound + sp.deffensive_rebound) AS rebound,
                    SUM(sp.assists) AS assists,
                    SUM(sp.commited_foul) AS commited_foul,
                    SUM(sp.recieved_foul) AS recieved_foul,
                    SUM(sp.turnover) AS turnover,
                    SUM(sp.steal) AS steal,
                    SUM(sp.in_fawor) AS in_fawor,
                    SUM(sp.`against`) AS against,
                    SUM(sp.effectiveness) AS effectiveness,
                    SUM(sp.points_scored) AS points_scored,
                    SUM(sp.`plus_minus`) AS plus_minus
                FROM statistic_games sg
                JOIN statistic_players sp ON sp.game_id = sg.game_id
                JOIN players p ON p.player_id = sp.player_id
                WHERE sg.tournament_id IN (' . $tournamentIdsString . ') ' . $seasonSql . '
                GROUP BY p.player_id'
            );
            $sth->execute();
            $res = $sth->fetchAll(PDO::FETCH_ASSOC);

            foreach ($res as &$player) {
                $player['player_time'] = $this->getPlayerTime($player['seconds']);
            }
            unset($player);

            Cache::setStatistic(Cache::CACHE_KEY_TOTAL, $res, $seasonId, $tournamentIds);
        }

        return $res;
    }

    /**
     * @param $data
     * @return bool
     */
    public function addHistoryGame($data)
    {
        return $this->insert(self::TABLE_NAME_HISTORY_GAMES, $data);
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
            Cache::clearAllCache();
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

	public function getPlayerTime($seconds) {
	    if (!$seconds) {
	        return '0:00';
        }
        $sec = date("s", $seconds);
        $min = ($seconds - $sec)/60;

        return $min . ':' . $sec;
    }

    private function _getGamesRecordData($seasonId, $tournamentIds) {
        $tournamentIdsString = implode(',', $tournamentIds);
        $sth = $this->_db->prepare(
            'SELECT
                sg.game_id,
                DATE_FORMAT(sg.dt, "%d.%m.%Y") AS dt,
                t.team_id,
                t.name AS opponent,
                SUM(sp.`two_point_made`) AS two_point_made,
                SUM(sp.`two_point_throw`) AS two_point_throw,
                SUM(sp.`three_point_made`) AS three_point_made,
                SUM(sp.`three_point_throw`) AS three_point_throw,
                SUM(sp.`two_point_made` + sp.`three_point_made`) AS two_three_point_made,
                SUM(sp.`two_point_throw` + sp.`three_point_throw`) AS two_three_point_throw,
                ROUND(SUM(sp.`two_point_made`) * 100 / SUM(sp.`two_point_throw`), 1) AS two_point_percent,
                ROUND(SUM(sp.`three_point_made`) * 100 / SUM(sp.`three_point_throw`), 1) AS three_point_percent,
                ROUND((SUM(sp.`two_point_made`) + SUM(sp.`three_point_made`)) * 100 / (SUM(sp.`two_point_throw`) + SUM(sp.`three_point_throw`)), 1) AS two_three_point_percent,
                SUM(sp.free_made) AS free_made,
                SUM(sp.free_throw) AS free_throw,
                SUM(sp.offensive_rebound) AS offensive_rebound,
                SUM(sp.deffensive_rebound) AS deffensive_rebound,
                SUM(sp.assists) AS assists,
                SUM(sp.commited_foul) AS commited_foul,
                SUM(sp.recieved_foul) AS recieved_foul,
                SUM(sp.turnover) AS turnover,
                SUM(sp.steal) AS steal,
                SUM(sp.in_fawor) AS in_fawor,
                SUM(sp.`against`) AS against,
                SUM(sp.effectiveness) AS effectiveness,
                SUM(sp.points_scored) AS points_scored,
                SUM(sp.`plus_minus`) AS plus_minus,
                SUM(sg.score) AS score
            FROM statistic_games sg
            JOIN statistic_players sp ON sp.game_id = sg.game_id
            JOIN teams t ON sg.team_id = t.team_id
            WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
            GROUP BY sg.game_id'
        );
        $sth->execute([$seasonId]);

        return $sth->fetchAll(PDO::FETCH_ASSOC);
    }

    private function _getPlayersRecordData($seasonId, $tournamentIds) {
        $tournamentIdsString = implode(',', $tournamentIds);
        $sth = $this->_db->prepare(
            'SELECT
                p.player_id,
                p.name,
                p.surname,
                count(sp.player_id) AS count_games,
                SUM(sp.`seconds`) AS seconds,
                SUM(sp.`two_point_made`) AS two_point_made,
                SUM(sp.`two_point_throw`) AS two_point_throw,
                SUM(sp.`three_point_made`) AS three_point_made,
                SUM(sp.`three_point_throw`) AS three_point_throw,
                SUM(sp.`two_point_made` + sp.`three_point_made`) AS two_three_point_made,
                SUM(sp.`two_point_throw` + sp.`three_point_throw`) AS two_three_point_throw,
                ROUND(SUM(sp.`two_point_made`) * 100 / SUM(sp.`two_point_throw`), 1) AS two_point_percent,
                ROUND(SUM(sp.`three_point_made`) * 100 / SUM(sp.`three_point_throw`), 1) AS three_point_percent,
                ROUND((SUM(sp.`two_point_made`) + SUM(sp.`three_point_made`)) * 100 / (SUM(sp.`two_point_throw`) + SUM(sp.`three_point_throw`)), 1) AS two_three_point_percent,
                SUM(sp.free_made) AS free_made,
                SUM(sp.free_throw) AS free_throw,
                SUM(sp.offensive_rebound) AS offensive_rebound,
                SUM(sp.deffensive_rebound) AS deffensive_rebound,
                SUM(sp.assists) AS assists,
                SUM(sp.commited_foul) AS commited_foul,
                SUM(sp.recieved_foul) AS recieved_foul,
                SUM(sp.turnover) AS turnover,
                SUM(sp.steal) AS steal,
                SUM(sp.in_fawor) AS in_fawor,
                SUM(sp.`against`) AS against,
                SUM(sp.effectiveness) AS effectiveness,
                SUM(sp.points_scored) AS points_scored,
                SUM(sp.`plus_minus`) AS plus_minus,
                SUM(sg.score) AS score
            FROM statistic_players sp
            JOIN statistic_games sg ON sp.game_id = sg.game_id
            JOIN players p ON p.player_id = sp.player_id
            WHERE sg.tournament_id IN (' . $tournamentIdsString . ') AND sg.season_id = ?
            GROUP BY p.player_id'
        );
        $sth->execute([$seasonId]);

        return $sth->fetchAll(PDO::FETCH_ASSOC);
    }

    private function _getSumColumns($data)
    {
        $sum = [];
        $ignoreCategory = [
            'dt',
            'name',
            'score',
            'surname',
            'team_name',
            'player_id',
        ];

        foreach ($data as $player) {
            foreach ($player as $category => $res) {
                if (!in_array($category, $ignoreCategory)) {
                    $sum[$category] += (int) $res;
                }

            }

        }

        return $sum;
    }

    private function _getCalculateRecords($gamesRecordData, $playersRecordData) {
	    return [
            'games'   => $this->_getCalculateGamesRecords($gamesRecordData),
	        'players' => $this->_getCalculatePlayersRecords($playersRecordData)
        ];
    }

    private function _getCalculateGamesRecords($gamesRecordData) {
	    $recordsGames = [];
        $recordGamesFields = [
            'two_point_made' => '2-очк З',
            'two_point_throw' => '2-очк Б',
            'three_point_made' => '3-очк З',
            'three_point_throw' => '3-очк Б',
            'two_three_point_made' => 'Бр З',
            'two_three_point_throw' => 'Бр Б',
            'two_point_percent' => '2-очк %',
            'three_point_percent' => '3-очк %',
            'two_three_point_percent' => 'Бр %',
            'free_made' => 'ШТ З',
            'free_throw' => 'ШТ Б',
            'offensive_rebound' => 'Пд Ч',
            'deffensive_rebound' => 'Пд С',
            'assists' => 'РП',
            'commited_foul' => 'Ф иг',
            'recieved_foul' => 'Ф на',
            'turnover' => 'Пт',
            'steal' => 'Пх',
            'in_fawor' => 'Бш иг',
            'against' => 'Бш на',
            'effectiveness' => 'Эфф',
            'plus_minus' => '+/-',
            'points_scored' => 'О',
        ];

        foreach ($gamesRecordData as $row) {
            foreach ($recordGamesFields as $field => $alias) {
                if ($row[$field] > $recordsGames[$field][$field]) {
                    $recordsGames[$field] = $row;
                    $recordsGames[$field]['alias'] = $alias;
                }
            }
        }

        return $recordsGames;
    }

    private function _getCalculatePlayersRecords($playersRecordData) {
        $recordsPlayers = [];
        $recordPlayersFields = [
            'seconds' => 'Минут за игру',
            'two_point_made' => '2-очк З за игру',
            'two_point_throw' => '2-очк Б за игру',
            'three_point_made' => '3-очк З за игру',
            'three_point_throw' => '3-очк Б за игру',
            'two_three_point_made' => 'Забитые с игры',
            'two_three_point_throw' => 'Броски с игры',
            'two_point_percent' => '2-очк %',
            'three_point_percent' => '3-очк %',
            'two_three_point_percent' => 'Б %',
            'free_made' => 'ШТ З за игру',
            'free_throw' => 'ШТ Б за игру',
            'offensive_rebound' => 'Подборов на чужом щите',
            'deffensive_rebound' => 'Подборов на своем щите',
            'assists' => 'Передачи за игру',
            'commited_foul' => 'Всего фолов за игру',
            'recieved_foul' => 'Всего фолов на игроке за игру',
            'turnover' => 'Потери за игру',
            'steal' => 'Перехваты',
            'in_fawor' => 'Блоки за игру',
            'against' => 'Блоки на игроке за игру',
            'effectiveness' => 'Эфф за игру',
            'plus_minus' => '+/-',
            'points_scored' => 'Очки за игру',
        ];

        foreach ($playersRecordData as $row) {
            $tempPlayer = $row;

            foreach ($recordPlayersFields as $field => $alias) {
                $tempPlayer[$field] = round($tempPlayer[$field] / $tempPlayer['count_games'], 1);

                if ($tempPlayer[$field] > $recordsPlayers[$field][$field]) {
                    $recordsPlayers[$field] = $tempPlayer;
                    $recordsPlayers[$field]['alias'] = $alias;
                }
            }
        }
        $recordsPlayers['seconds']['player_time'] = $this->getPlayerTime($recordsPlayers['seconds']['seconds']);

        return $recordsPlayers;
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
				    // Фикс для некоторых бд
                    if ($title === self::FIELDS[self::FIELD_VENUE]) {
                        $statistic = (int) $statistic;
                    }
					$statisticGame[$key][$title] = $statistic;
				}

				if (in_array($title, self::FIELD_FOR_STATICTIC_PLAYER)) {
					$statisticPlayer[$key][$title] = $statistic ?: 0;
				}
			}
		}

		// убираем дублирование
		$finishStatisticGame = [];
		if ($statisticGame) {
			$gameIds = [];
			foreach ($statisticGame as $key => $value) {
				if (!in_array($value[self::FIELDS[self::FIELD_GAME_ID]], $gameIds)) {
					$value[self::FIELDS[self::FIELD_DATE]] = date('Y-m-d', strtotime($value[self::FIELDS[self::FIELD_DATE]]));
					$finishStatisticGame[] = $value;
					$gameIds[] = (int) $value[self::FIELDS[self::FIELD_GAME_ID]];
				}
			}
		}

		return [
			'statisticGame'		=> $finishStatisticGame,
			'statisticPlayer'	=> $statisticPlayer
		];
	}

	private function _saveStaticticGame($data) {
		return $this->insert(self::TABLE_NAME_STATISTIC_GAMES, $data);
	}

	private function _saveStaticticPlayer($data) {
		return $this->insert(self::TABLE_NAME_STATISTIC_PLAYERS, $data);
	}
}