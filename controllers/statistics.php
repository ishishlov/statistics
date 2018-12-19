<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';

class Statistics extends Common {
	
	private $_model = null;
	
	const FIELDS = [
		0 => 'sezon',
		1 => 'is_home',
		2 => 'min',
		3 => 'z2',
		4 => 'b2',
		5 => 'z3',
		6 => 'b3',
		7 => 'z23',
		8 => 'b23',
		9 => 'qw',
		10 => 'we',
		11 => 'er',
		12 => 'rt',
		13 => 'ty',
		14 => 'yu',
		15 => 'ui',
		16 => 'io',
		17 => 'as',
		18 => 'sd',
		19 => 'df',
		20 => 'fg',
		21 => 'gh',
		22 => 'hj',
		23 => 'jk',
		24 => 'kl',
		25 => 'la',
	];
	
	public function __construct() {
		$this->_model = new StatisticsModel();
	}

	public function index() {
		$this->display('index.tpl');
	}
	
	public function save() {
		setlocale(LC_ALL, 'en_US.utf8');
		$csv = [];

		// check there are no errors
		if($_FILES['csv']['error'] == 0){
			$name = $_FILES['csv']['name'];
			$ext = strtolower(end(explode('.', $_FILES['csv']['name'])));
			$type = $_FILES['csv']['type'];
			$tmpName = $_FILES['csv']['tmp_name'];

			// check the file is a csv
			if($ext === 'csv'){
				if(($handle = fopen($tmpName, 'r')) !== false) {
					// necessary if a large csv file
					set_time_limit(0);

					$row = 0;

					while(($data = fgetcsv($handle, 1000)) !== false) {
						$data = array_map("utf8_encode", $data);
						// number of fields in the csv
						$col_count = count($data);

						// get the values from the csv
						$csv[] = $data[0];

						// inc the row
						$row++;
					}
					fclose($handle);
				}
			}
		}

		
		$dataArray = [];
		foreach ($csv as $dataString) {
			$dataArray[] = explode(';', $dataString);
		}
		
		$finalData = [];
		
		foreach ($dataArray as $key1 => $row) {
			foreach ($row as $key2 => $value) {
				
				$finalData[$key1][self::FIELDS[$key2]] = $value;
			}
		}
		$this->vd($finalData);exit;
	}

	public function get() {
		$data = $this->_model->get();
		echo '<pre>';
		var_dump($data);
		echo '</pre>';
		exit;
	}
}