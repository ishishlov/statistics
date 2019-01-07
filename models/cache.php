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
		$memcache = self::getMemcache();
		return $memcache->get($key);
	}

	/**
	 * Запись в кеш
	 * 
	 * @param string $key
	 * @param mixed $data
	 * @param bool [default = 0] $flag
	 * @param int [default = 604800 (7 дней)] $expire
	 * @return bool
	 */
	public static function setValue($key, $data, $flag = 0, $expire = 604800) {
		$memcache = self::getMemcache();
		return $memcache->set($key, $data, $flag, $expire);
	}

	/**
	 * Удалить значение кеша
	 * 
	 * @param string $key
	 * @return bool
	 */
	public static function deleteValue($key) {
		$memcache = self::getMemcache();
		return $memcache->delete($key);
	}

	private static function getMemcache() {
		if (!self::$_memcache) {
			self::$_memcache = new Memcache();
			self::$_memcache->connect(self::HOST, self::PORT) or die('Could not connect');
		}
		return self::$_memcache;
	}
}