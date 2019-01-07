<?php

class Cache {
	
	private static $_memcache = null;

	const HOST = '127.0.0.1';
	const PORT = 11211;

	/**
	 * Получить значение кеша
	 * 
	 * @param string $key
	 * @return bool
	 */
	public static function getValue($key) {
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
		$memcache = self::_getMemcache();
		return $memcache->delete($key);
	}

	public static function getStatistic($key, $seasonId, $tournamentIds) {
		$res = null;
		$tournamentId = count($tournamentIds) === 1 ? (int) $tournamentIds[0] : 999;
		$data = self::getValue($key);

		if ($data && $data[$seasonId] && $data[$seasonId][$tournamentId]) {
			$res = $data[$seasonId][$tournamentId];
		}

		return $res;
	}

	public static function setStatistic($key, $data, $seasonId, $tournamentIds, $flag = 0, $expire = 604800) {
		return false;//временная заглушка
		$tournamentId = count($tournamentIds) === 1 ? (int) $tournamentIds[0] : 999;
		$finishData = self::getValue($key);
		$finishData[$seasonId][$tournamentId] = $data;

		return self::setValue($key, $finishData, $flag, $expire);
	}

	public static function deleteStatistic($key, $seasonId, $tournamentIds) {
		$tournamentId = count($tournamentIds) === 1 ? (int) $tournamentIds[0] : 999;
		$data = self::getValue($key);
		$data[$seasonId][$tournamentId] = null;
		$res = self::setStatistic($key, $data, $seasonId, $tournamentIds);

		return $res;
	}

	private static function _getMemcache() {
		if (!self::$_memcache) {
			self::$_memcache = new Memcache();
			self::$_memcache->connect(self::HOST, self::PORT) or die('Could not connect');
		}
		return self::$_memcache;
	}
}