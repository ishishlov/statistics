<?php
require_once 'models/Main.php';
require_once 'models/Cache.php';

class HystoryTeamsTotal extends Main {

	/** Статус протокола статистики - подтвержен */
	const STATUS_CONFIRMED = 1;
	/** Статус протокола статистики - не подтвержен */
	const STATUS_NOT_CONFIRMED = 2;
	/** Название таблицы статистики игр */
	const TABLE_NAME = 'history_teams_total';
	/** Выбор по всем сезонам */
	const ALL_SEASONS = 999;

	const FIELDS = [
		0 => '`number`',
		1 => '`team_id`',
		2 => '`two_point_made`',
		3 => '`two_point_throw`',
		4 => '`two_point_percent`',
		5 => '`three_point_made`',
		6 => '`three_point_throw`',
		7 => '`three_point_percent`',
		8 => '`two_three_point_made`',
		9 => '`two_three_point_throw`',
		10 => '`two_three_point_percent`',
		11 => '`free_made`',
		12 => '`free_throw`',
		13 => '`free_percent`',
		14 => '`offensive_rebound`',
		15 => '`deffensive_rebound`',
		16 => '`sum_rebound`',
		17 => '`assists`',
		18 => '`commited_foul`',
		19 => '`recieved_foul`',
		20 => '`turnover`',
		21 => '`steal`',
		22 => '`in_fawor`',
		23 => '`against`',
		24 => '`effectiveness`',
		25 => '`scipped1`',
		26 => '`scipped2`',
		27 => '`plus_minus`',
		28 => '`scipped3`',
		29 => '`scipped4`',
		30 => '`tournament_id`',
		31 => '`scipped5`',
		32 => '`points_scored`',
		33 => '`season_id`',
		34 => '`status`'
	];
	
	const SCIPPED_FIELDS = [25,26,28,29,31];

	public function save($Csv) {
        $data = $Csv->getArray();
        $data = $this->_getCorrectKeyArray($data);
        $data = $this->_removeFirstRow($data);

        $seasonId = $this->getSeasonId($data);
		$oldIds = $this->getIdsBySeasonId($seasonId);
        $res = $this->deleteByIds($oldIds);

        if ($res) {
            $res = $this->_saveHistoryTeamsTotal($data);
        }

		return $res;
	}

	public function getSeasonId($data) {
	    return $data[0][self::FIELDS[33]] ?: 0;
    }

    public function getHistoryTeamsTotal($seasonId, $tournamentIds) {
		$seasonId = (int) $seasonId;
        $res = Cache::getStatistic(Cache::CACHE_KEY_HISTORY, $seasonId, $tournamentIds);
        if (!$res) {
			$seasonSql = ($seasonId === self::ALL_SEASONS) ? '' : 'AND htt.season_id = ' . $seasonId;
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
                WHERE htt.tournament_id IN (' . $tournamentIdsString . ') ' . $seasonSql . '
                ORDER BY htt.number ASC'
            );
            $sth->execute();
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
			FROM ' . self::TABLE_NAME . ' htt
            LEFT JOIN teams t ON t.team_id = htt.team_id
            WHERE `status` = ?
            ORDER BY htt.number ASC
		');
		$sth->execute([self::STATUS_NOT_CONFIRMED]);
        return $sth->fetchAll(PDO::FETCH_ASSOC);
	}

	/**
	 * @return bool
	 */
	public function confirmedProtocol() {
		$res = false;
		$ids = $this->getNotConfirmedIds();

		if ($ids) {
			$idsString = implode(', ', $ids);
			$stmt = $this->_db->prepare('UPDATE ' . self::TABLE_NAME . ' SET `status` = ? WHERE `history_teams_total_id` IN(' . $idsString . ')');
			$res = $stmt->execute([self::STATUS_CONFIRMED]);
		}

		return $res;
	}

	/**
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
		if (!$ids) {
			return true;
		}
        $idsString = implode(', ', $ids);
        $stmt = $this->_db->prepare('DELETE FROM ' . self::TABLE_NAME . ' WHERE `history_teams_total_id` IN(' . $idsString . ')');

        return $stmt->execute();
    }

	private function _saveHistoryTeamsTotal($data) {
		return $this->insert(self::TABLE_NAME, $data);
	}

    /**
     * Установка корректных названий элементам массива и добавление поле "статус"
     *
     * @param array $data
     * @return array
     */
    private function _getCorrectKeyArray($data) {
        if (!$data) {
            return [];
        }

        $finalData = [];
        foreach ($data as $key1 => $row) {
            foreach ($row as $key2 => $value) {
				if (!in_array($key2, self::SCIPPED_FIELDS)) {
					$finalData[$key1][self::FIELDS[$key2]] = mb_convert_encoding($value, "utf-8", "windows-1251");
				}
            }
            $finalData[$key1][self::FIELDS[34]] = self::STATUS_NOT_CONFIRMED;
        }

        return $finalData;
    }

    /**
     * Удалить первую строку если она состоит из заголовков
     *
     * @param array $data
     * @return array
     */
    private function _removeFirstRow($data) {
        $temp = (int)$data[0][self::FIELDS[0]];
        if (!$temp) {
            array_shift($data);
        }
        return $data;
    }
}