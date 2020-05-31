<?php

class Route {
	
	public static function routing() {
		
		$url = trim($_SERVER['REQUEST_URI']);
		if (!$url || $url === '/' || $url === 'index') {
			$controllerName = 'statistics';
			$method = 'index';
		} else {
			$urlArray = explode('/', $url);
			$controllerName = ucfirst(trim($urlArray[1]));
			$methodArray = explode('?', trim($urlArray[2]));
            $method = $methodArray[0];
		}

		$file = 'controllers/' . $controllerName . '.php';
		if (!file_exists($file)) {
			header("HTTP/1.0 404 Not Found");
			//print('Данной страницы не существует!');
			exit;
		}

		require_once $file;
		
		$Controller = new $controllerName;
		if (!method_exists($Controller, $method)) {
			header("HTTP/1.0 404 Not Found");
			//print('Данного метода не существует!');
			exit;
		}

		$Controller->$method();
	}
}