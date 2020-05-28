<?php

namespace Models;

use PDO;

class Teams extends Main {

    const TABLE_NAME_TEAMS = 'teams';

    public function getTeams() {
        $sth = $this->_db->prepare(
            'SELECT
                team_id,
                `name`
			FROM ' . self::TABLE_NAME_TEAMS . '
            ORDER BY `name` ASC'
        );
        $sth->execute();
        return $sth->fetchAll(PDO::FETCH_ASSOC);
    }
}