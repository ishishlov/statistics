<?php

namespace Models;

class Cache {
	
	private static $_memcache = null;

	const HOST = '127.0.0.1';
	const PORT = 11211;

	const CACHE_IS_ENABLED = false;

    const CACHE_KEY_SEASONS_STATISTIC       = 'seasonsStatistic';
    const CACHE_KEY_GAMES_STATISTIC         = 'gamesStatistic';
    const CACHE_KEY_PLAYERS_STATISTIC       = 'playersStatistic';
    const CACHE_KEY_PLAYER_STATISTIC        = 'playerStatistic';
    const CACHE_KEY_PLAYER_GAMES_STATISTIC  = 'playerGamesStatistic';
    const CACHE_KEY_PLAYER_INFO             = 'playerInfo';
    const CACHE_KEY_HISTORY                 = 'history';
    const CACHE_KEY_HISTORY_TEAMS_TOTAL     = 'historyTeamsTotal';
    const CACHE_KEY_RECORDS                 = 'records';
    const CACHE_KEY_TOTAL                   = 'total';

    const CACHE_KEY_SEASONS = 'seasons';
    const CACHE_KEY_TOURNAMENTS = 'tournaments';

    const CACHE_KEYS = [
        self::CACHE_KEY_SEASONS_STATISTIC,
        self::CACHE_KEY_GAMES_STATISTIC,
        self::CACHE_KEY_PLAYERS_STATISTIC,
        self::CACHE_KEY_PLAYER_STATISTIC,
        self::CACHE_KEY_PLAYER_GAMES_STATISTIC,
        self::CACHE_KEY_PLAYER_INFO,
        self::CACHE_KEY_HISTORY,
        self::CACHE_KEY_RECORDS,
        self::CACHE_KEY_TOTAL,
        self::CACHE_KEY_SEASONS,
        self::CACHE_KEY_TOURNAMENTS
    ];

	/**
	 * Получить значение кеша
	 * 
	 * @param string $key
	 * @return bool
	 */
	public static function getValue($key) {
	    if (!self::CACHE_IS_ENABLED) {
	        return false;
        }

		$memcache = self::_getMemcache();
		return $memcache->get($key);
	}

	/**
	 * Запись в кеш
	 * 
	 * @param string $key
	 * @param mixed $data
	 * @param int [default = 0] $flag
	 * @param int [default = 604800 (7 дней)] $expire
	 * @return bool
	 */
	public static function setValue($key, $data, $flag = 0, $expire = 604800) {
        if (!self::CACHE_IS_ENABLED) {
            return false;
        }

		$memcache = self::_getMemcache();
		return $memcache->set($key, $data, $flag, $expire);
	}

	/**
	 * Удалить значение кеша
	 * 
	 * @param string $key
	 * @return bool
	 */
	public static function deleteValue($key) {
        if (!self::CACHE_IS_ENABLED) {
            return false;
        }

		$memcache = self::_getMemcache();
		return $memcache->delete($key);
	}

	public static function getStatistic($key, $seasonId, $tournamentIds) {
		$res = null;
		$tournamentId = self::_getTournamentId($tournamentIds);
		$data = self::getValue($key);

		if ($data && isset($data[$seasonId][$tournamentId])) {
			$res = $data[$seasonId][$tournamentId];
		}

		return $res;
	}

	public static function setStatistic($key, $data, $seasonId, $tournamentIds, $flag = 0, $expire = 604800) {
		$tournamentId = self::_getTournamentId($tournamentIds);
		$finishData = self::getValue($key);
		if ($finishData) {
            $finishData[$seasonId][$tournamentId] = $data;

            return self::setValue($key, $finishData, $flag, $expire);
        }
		return false;
	}

	public static function deleteStatistic($key, $seasonId, $tournamentIds) {
		$tournamentId = self::_getTournamentId($tournamentIds);
		$data = self::getValue($key);
		if ($data) {
            unset($data[$seasonId][$tournamentId]);
            $res = self::setStatistic($key, $data, $seasonId, $tournamentIds);

            return $res;
        }
		return false;
	}

    public static function getPlayerStatistic($key, $playerId, $seasonId, $tournamentIds) {
        $res = null;
        $tournamentId = self::_getTournamentId($tournamentIds);
        $data = self::getValue($key);

        if ($data && isset($data[$seasonId][$tournamentId])) {
            $res = $data[$playerId][$seasonId][$tournamentId];
        }

        return $res;
    }

    public static function setPlayerStatistic($key, $data, $playerId, $seasonId, $tournamentIds, $flag = 0, $expire = 604800) {
        $tournamentId = self::_getTournamentId($tournamentIds);
        $finishData = self::getValue($key);
        if ($finishData) {
            $finishData[$playerId][$seasonId][$tournamentId] = $data;

            return self::setValue($key, $finishData, $flag, $expire);
        }
        return false;
    }

    public static function deletePlayerStatistic($key, $playerId, $seasonId, $tournamentIds) {
        $tournamentId = self::_getTournamentId($tournamentIds);
        $data = self::getValue($key);
        if ($data) {
            unset($data[$playerId][$seasonId][$tournamentId]);
            $res = self::setPlayerStatistic($key, $data, $playerId, $seasonId, $tournamentIds);

            return $res;
        }
        return false;
    }

    public static function getInfo($key, $id) {
        $res = null;
        $data = self::getValue($key);

        if ($data && isset($data[$id])) {
            $res = $data[$id];
        }

        return $res;
    }

    public static function setInfo($key, $data, $id, $flag = 0, $expire = 604800) {
        $finishData = self::getValue($key);
        if ($finishData) {
            $finishData[$id] = $data;

            return self::setValue($key, $finishData, $flag, $expire);
        }
        return false;
    }

    public static function deleteInfo($key, $id) {
        $data = self::getValue($key);
        if ($data) {
            unset($data[$id]);
            $res = self::setInfo($key, $data, $id);

            return $res;
        }
        return false;
    }

    /**
     * @return bool
     */
    public static function clearAllCache() {
        foreach (self::CACHE_KEYS as $key) {
            if (!self::deleteValue($key)) {
                return false;
            }
        }

        return true;
    }

	private static function _getMemcache() {
		if (!self::$_memcache) {
			self::$_memcache = new Memcache();
			self::$_memcache->connect(self::HOST, self::PORT) or die('Could not connect');
		}
		return self::$_memcache;
	}

    private static function _getTournamentId($tournamentIds) {
	    return count($tournamentIds) === 1 ? (int) $tournamentIds[0] : 999;
    }
}