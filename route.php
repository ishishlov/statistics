<?php

class Route {
	
	public static function routing() {
		$url = trim($_SERVER['REQUEST_URI']);
		if (!$url) {
			$controllerName = 'index.php';
			$method = 'index';
			$file = 'controllers/' . mb_strtolower($controllerName);
		} else {
			$urlArray = explode('/', $url);
			$controllerName = trim($urlArray[1]);
			$method = trim($urlArray[2]);
			$file = mb_strtolower('controllers/' . $controllerName . 'php');
		}
		
		if (!file_exists($file)) {
			print('Данной страницы не существует!');
			exit;
		}

		require_once $file;
		$Controller = new $controllerName;
		if (!method_exists($Controller, $method)) {
			print('Данного метода не существует!');
			exit;
		}
		$Controller->$method();
	}
}