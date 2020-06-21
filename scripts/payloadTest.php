<?php

require_once '../vendor/autoload.php';

$Model = new Models\AllStatistics();
$HistoryModel = new Models\HystoryTeamsTotal();
$seasonId = 17;
$tournamentIds = [2];
$gameId = 1111;
$playerId = 81;

//////
$times['now'] = microtime(true);
for ($i = 1; $i<=1000; $i++) {
    $Model->getGamesData($seasonId, $tournamentIds);
    $Model->getAllSeasons();
    if ($i === 1) {
        $times['run1'] = microtime(true);
    }

    if ($i === 10) {
        $times['run10'] = microtime(true);
    }

    if ($i === 100) {
        $times['run100'] = microtime(true);
    }
}
$times['run1000'] = microtime(true);

printMessage('Command statistic (first tab)', $times, 1);

//////
$times['now'] = microtime(true);
for ($i = 1; $i<=1000; $i++) {
    $Model->getGameInfo(1111);
    if ($i === 1) {
        $times['run1'] = microtime(true);
    }

    if ($i === 10) {
        $times['run10'] = microtime(true);
    }

    if ($i === 100) {
        $times['run100'] = microtime(true);
    }
}
$times['run1000'] = microtime(true);

printMessage('Match result (first tab)', $times, 2);

//////
$times['now'] = microtime(true);
for ($i = 1; $i<=1000; $i++) {
    $Model->getPlayers($seasonId, $tournamentIds);
    $Model->getAllSeasons();
    if ($i === 1) {
        $times['run1'] = microtime(true);
    }

    if ($i === 10) {
        $times['run10'] = microtime(true);
    }

    if ($i === 100) {
        $times['run100'] = microtime(true);
    }
}
$times['run1000'] = microtime(true);

printMessage('Players (second tab)', $times, 3);

//////
$times['now'] = microtime(true);
for ($i = 1; $i<=1000; $i++) {
    $Model->getPlayerStatistic($playerId, $seasonId, $tournamentIds);
    $Model->getPlayerGamesStatistic($playerId, $seasonId, $tournamentIds);
    $Model->getPlayer($playerId);
    $Model->getAllSeasons();
    if ($i === 1) {
        $times['run1'] = microtime(true);
    }

    if ($i === 10) {
        $times['run10'] = microtime(true);
    }

    if ($i === 100) {
        $times['run100'] = microtime(true);
    }
}
$times['run1000'] = microtime(true);

printMessage('Player info (second tab)', $times, 4);

//////
$times['now'] = microtime(true);
for ($i = 1; $i<=1000; $i++) {
    $Model->getHistoryTables($seasonId, $tournamentIds);
    $Model->getHistoryRecords($seasonId, $tournamentIds);
    $HistoryModel->getHistoryTeamsTotal($seasonId, $tournamentIds);
    if ($i === 1) {
        $times['run1'] = microtime(true);
    }

    if ($i === 10) {
        $times['run10'] = microtime(true);
    }

    if ($i === 100) {
        $times['run100'] = microtime(true);
    }
}
$times['run1000'] = microtime(true);

printMessage('History (third tab)', $times, 5);

echo PHP_EOL . 'The script is finished';


function calcTime($startTime, $finishTime) {
    return substr($finishTime - $startTime, 0, 7);
}

function printMessage($name, $times, $numberTest) {
    $text = sprintf(
        "(%d/5) Run time %s:\n 1 run - %s sec\n 10 run - %s sec\n 100 run - %s sec\n 1000 run - %s sec\n\n",
        $numberTest,
        $name,
        calcTime($times['now'], $times['run1']),
        calcTime($times['now'], $times['run10']),
        calcTime($times['now'], $times['run100']),
        calcTime($times['now'], $times['run1000'])
    );

    if (empty($_GET['web'])) {
        print($text);
    } else {
        echo '<pre>';
        print($text);
        echo '</pre>';
    }
}
