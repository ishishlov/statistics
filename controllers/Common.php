<?php

require_once __DIR__ . '/../vendor/autoload.php';

class Common {

	protected $_data = [];

	public function display($template) {
		$twig = new Twig_Environment(new Twig_Loader_Filesystem('views/tpl'));
		$twig->display($template, $this->_data);
	}

	public function toJson($data) {
		print(json_encode($data));
		exit;
	}

	/**
	 * Привести вложенность массива к числу
	 * 
	 * @param array $data
	 * @return array Description
	 */
	public function arrayToInt($data) {
		if (is_array($data)) {
			foreach ($data as &$value) {
				$value = (int) $value;
			}
		}
		return $data;
	}

	public function vd($data) {
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
	}
}