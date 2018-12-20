<?php

require_once 'vendor/autoload.php';

class Common {
	
	protected $_twig;
	
	public function display($template, $data = []) {
		$twig = new Twig_Environment(new Twig_Loader_Filesystem('views'));
		$twig->display($template);
	}
	
	public function vd($data) {
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
	}
}