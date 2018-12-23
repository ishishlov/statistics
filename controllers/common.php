<?php

require_once 'vendor/autoload.php';

class Common {

	protected $_twig;
	protected $_data = [];

	public function display($template) {
		$twig = new Twig_Environment(new Twig_Loader_Filesystem('views'));
		$twig->display($template, $this->_data);
	}

	public function vd($data) {
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
	}
}