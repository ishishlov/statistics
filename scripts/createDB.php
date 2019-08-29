<?php

require_once '../models/db.php';

$dir = '../db';
$names = scandir($dir);
array_shift($names);
array_shift($names);
$db = (new DB())->getInstance();
$i = 1;
$countTables = count($names);

foreach ($names as $name) {
    $sql = file_get_contents($dir . '/' . $name);
    $stmt = $db->prepare($sql);
    $res = $stmt->execute();
    if ($res) {
        printMessage($i, $countTables, $name, 'OK');
    } else {
        printMessage($i, $countTables, $name, 'FAILED');
    }
    $i++;
}


function printMessage($i, $count, $name, $status) {
    $pos = strlen($name) - 4;
    $name = substr($name, 0, $pos);
    print("({$i}/{$count}) Status - {$status}. Add table {$name}" . PHP_EOL);
}