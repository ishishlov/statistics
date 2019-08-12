<?php
require_once 'models/main.php';
require_once 'models/cache.php';

class HystoryTeamsTotalModel extends Main {

	/** Статус протокола статистики - подтвержен */
	const STATUS_CONFIRMED = 1;
	/** Статус протокола статистики - не подтвержен */
	const STATUS_NOT_CONFIRMED = 2;
	/** Название таблицы статистики игр */
	const TABLE_NAME = 'history_teams_total';

	const FIELDS = [
		0 => '`game_id`',
		1 => '`dt`',
		2 => '`tournament_id`',
		3 => '`team_id`',
		4 => '`player_id`',
		5 => '`season_id`',
		6 => '`venue`',
		7 => '`seconds`',
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

	public function save($Csv) {
        $data = $Csv->getArray();

        $seasonId = $this->getSeasonId($data);
		$oldIds = $this->getIdsBySeasonId($seasonId);
        $res = $this->deleteByIds($oldIds);
        if ($res) {
            $res = $this->_saveHistoryTeamsTotal($data);
        }

		return $res;
	}

	public function getSeasonId($data) {
	    return 16; // ToDo не забыть исправить заглушку
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

    /**
	 * Получить данные по неподтвержденному протоколу
	 * 
	 * @return array
	 */
	public function getNotConfirmedIds() {
		$sth = $this->_db->prepare('
			SELECT history_teams_total_id
			FROM `history_teams_total` 
			WHERE status = ?');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
		return $sth->fetchAll(PDO::FETCH_COLUMN);
	}

    public function getIdsBySeasonId($seasonId) {
        $sth = $this->_db->prepare('
			SELECT history_teams_total_id
			FROM `history_teams_total` 
			WHERE season_id = ?');
        $sth->execute([$seasonId]);
        return $sth->fetchAll(PDO::FETCH_COLUMN);
    }

	public function getNotConfirmedSeasonsStatistic() {
		$sth = $this->_db->prepare('
			SELECT 
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
            WHERE `status` = ?
            ORDER BY htt.number ASC
		');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
        return $sth->fetch(PDO::FETCH_ASSOC);
	}

	/**
	 * Подтверждение протокола матча
	 * 
	 * @return bool
	 */
	public function confirmedProtocol() {
		$res = false;
		$ids = $this->getNotConfirmedIds();
		if ($gameIds) {
			$idsString = implode(', ', $ids);
			$stmt = $this->_db->prepare('UPDATE ' . self::TABLE_NAME . ' SET `status` = ? WHERE `history_teams_total_id` IN(' . $idsString . ')');
			$res = $stmt->execute([self::STATUS_CONFIRMED]);
		}

		return $res;
	}

	/**
	 * Удаление неподтвержденного протокола матча
	 * 
	 * @return bool
	 */
	public function deleteNotConfirmedProtocol() {
		$ids = $this->getNotConfirmedIds();
		if ($ids) {
			return $this->deleteByIds($ids);
		}
		return true;
	}

    public function deleteByIds($ids) {
        $idsString = implode(', ', $ids);
        $stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME . ' WHERE `history_teams_total_id` IN(' . $idsString . ')');

        return $stmt->execute();
    }

	private function _saveHistoryTeamsTotal($data) {
		return $this->insert(self::TABLE_NAME, $data);
	}
}