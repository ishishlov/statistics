<?php
require_once 'controllers/common.php';
require_once 'models/statistics.php';

class Statistics extends Common {
	
	private $_model = null;
	
	public function __construct() {
		$this->_model = new StatisticsModel();
	}

    /**
	 * Страница командной статистики
	 */
	public function commandsStatistic() {
		$this->display('commandsstatistic.tpl');
	}

	public function getCommandsStatistic() {
        header('Access-Control-Allow-Origin: *');

		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			//'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'gamesData'         => $this->_model->getGamesData($seasonId, $tournamentIds)
		]);
	}

	public function getPlayersStatistic() {
        header('Access-Control-Allow-Origin: *');

		$seasonId = (int) $_POST['seasonId'];
		$tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

		$this->toJson([
			//'seasonsStatistic'	=> $this->_model->getSeasonsStatistic($seasonId, $tournamentIds),
			'playersStatistic'	=> $this->_model->getPlayers($seasonId, $tournamentIds)
		]);	
	}

    public function getPlayerData() {
        header('Access-Control-Allow-Origin: *');

        $playerId= (int) $_POST['playerId'];
        $seasonId = (int) $_POST['seasonId'];
        $tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

        $this->toJson([
            'playerStatistic'	    => $this->_model->getPlayerStatistic($playerId, $seasonId, $tournamentIds),
            'playerGamesStatistic'	=> $this->_model->getPlayerGamesStatistic($playerId, $seasonId, $tournamentIds),
            'playerInfo'            => $this->_model->getPlayer($playerId)
        ]);
    }

	public function getGameInfo() {
        header('Access-Control-Allow-Origin: *');

		$gameId = (int) $_POST['gameId'];

		$this->toJson([
            'gameInfo'	=> $this->_model->getGameInfo($gameId),
        ]);
	}

    public function getHistoryData() {
        header('Access-Control-Allow-Origin: *');

        $seasonId = (int) $_POST['seasonId'];
        $tournamentIds = $this->arrayToInt($_POST['tournamentIds']);

        $this->toJson([
            'historyTables'     => [
                'history' => $this->_model->getHistoryTables($seasonId, $tournamentIds),
                'history_teams_total' => $this->_model->getHistoryTeamsTotal($seasonId, $tournamentIds),
            ],
            'historyRecords'    => $this->_model->getHistoryRecords($seasonId, $tournamentIds),
            'historyTotal'      => $this->_model->getHistoryTotal($seasonId, $tournamentIds),
        ]);
    }

	public function getAllSeasons() {
        header('Access-Control-Allow-Origin: *');

		$this->toJson([
			'allSeasons' => $this->_model->getAllSeasons()
		]);
	}

	public function getTournaments() {
        header('Access-Control-Allow-Origin: *');

		$this->toJson([
			'tournaments' => $this->_model->getTournaments()
		]);
	}
}