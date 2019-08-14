(function($) {
	$(function() {
		statWidget.init();
	});
	var statWidget = (function() {
		var TOURNAMENTS = {
			vtb: {
				id: 1,
				name: 'Единая лига ВТБ'
			},
			euroLeague: {
				id: 2,
				name: 'Евролига'
			},
			euroCup: {
				id: 3,
				name: 'Еврокубок'
			},
			pbl: {
				id: 4,
				name: 'ПБЛ'
			},
			championshipRussia: {
				id: 5,
				name: 'Чемпионат России'
			},
			challengeCup: {
				id: 6,
				name: 'Кубок вызова'
			},
			russianCup: {
				id: 7,
				name: 'Кубок России'
			},
			topLeague: {
				id: 8,
				name: 'Высшая лига'
			},
			corachCup: {
				id: 9,
				name: 'Кубок Корача'
			},
			fibaEuroCup: {
				id: 10,
				name: 'Кубок ФИБА Европа'
			}
		};

		var CURRENT_SEASON = 17;
		var TOURNAMENTS_CONFIG = {
			16: {
				0: TOURNAMENTS.euroCup,
				1: TOURNAMENTS.vtb
			},
			17: {
				0: TOURNAMENTS.euroLeague,
				1: TOURNAMENTS.vtb
			}
		};

		var _module;
		var _domenName = '';
		var $_mainContainer;
		var _tournamentIds = [2];
		var _seasonId = CURRENT_SEASON;
		var _playerId = 0;
		var _gameId = 0;
		var _tabs = {
			commandStatistic: 1,
			players: 2,
			history: 3
		};
		var _activeTabId = _tabs.commandStatistic;

		var _gameLink = 'swgameid';
		var _playerLink = 'swplayerid';

		var ALL_TOURNAMENTS_ALIAS = 999;
		var ALL_TOURNAMENTS_IDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

		return {
			init: function() {
				_module = this;
				_module.setDomenName();
				$_mainContainer = $('#stat-widget');
				_module.renderWidget();

				//Переход по ссылке
				_module.goToLink();

				//Смена вкладки
				$_mainContainer.on('click', '.stat-widget-tab', function (event) {
					$('.stat-widget-tab').removeClass('active');
					$(event.target).addClass('active');
					_tournamentIds = [2];
					_seasonId = CURRENT_SEASON;
					_playerId = 0;
					_activeTabId = $(event.target).data('tab-id');
					switch (_activeTabId) {
						case _tabs.commandStatistic:
							_module.renderGamesStatistic();
							break;

						case _tabs.players:
							_module.renderPlayersStatistic();
							break;

						case _tabs.history:
							_module.renderHistory();
							break;

						default:
							_module.renderWidget();
							break;
					}
				});

				//Смена фильтра
				$_mainContainer.on('click', '.stat-widget-filter-tournament', function (event) {
					$('.stat-widget-filter-tournament').removeClass('active');
					$(event.target).addClass('active');
					var tournamentId = $(event.target).data('tournament-id');
					if (tournamentId == ALL_TOURNAMENTS_ALIAS) {
						_tournamentIds = ALL_TOURNAMENTS_IDS;
					} else {
						_tournamentIds = [tournamentId];
					}

					switch (_activeTabId) {
						case _tabs.commandStatistic:
							_module.getCommandsStatistic();
							break;

						case _tabs.players:
							if (_playerId) {
								_module.getPlayerInfo();
							} else {
								_module.getPlayersStatistic();
							}
							break;

						case _tabs.history:
							_module.renderHistoryData();
							break;

						default:
							_module.getCommandsStatistic();
							break;
					}
				});

				//Смена фильтра в истории
				$_mainContainer.on('change', '.stat-widget-filter-histoty-tournament', function (event) {
					var tournamentId = $(event.target).val();
					if (tournamentId == ALL_TOURNAMENTS_ALIAS) {
						_tournamentIds = ALL_TOURNAMENTS_IDS;
					} else {
						_tournamentIds = [tournamentId];
					}

					_seasonId = CURRENT_SEASON;
					$('.stat-widget-filter-season').val(_seasonId);

					switch (_activeTabId) {
						case _tabs.commandStatistic:
							_module.getCommandsStatistic();
							break;

						case _tabs.players:
							if (_playerId) {
								_module.getPlayerInfo();
							} else {
								_module.getPlayersStatistic();
							}
							break;

						case _tabs.history:
							_module.renderHistoryData();
							break;

						default:
							_module.getCommandsStatistic();
							break;
					}
				});

				//Смена вкладки в Истории
				$_mainContainer.on('click', '.stat-widget-history-tab', function (event) {
					$('.stat-widget-history-tab').removeClass('active');
					$(event.target).addClass('active');

					var historyTab = $(event.target).data('history-tab');
					if (historyTab) {
						$('.stat-widget-history-data').addClass('hide');
						$('.stat-widget-history-data-' + historyTab).removeClass('hide');
					}
				});

				//Смена сезона
				$_mainContainer.on('change', '.stat-widget-filter-season', function (event) {
					_seasonId = $(event.target).val();

					switch (_activeTabId) {
						case _tabs.commandStatistic:
							_module.getCommandsStatistic();
							break;
						case _tabs.players:
							_module.renderTournaments();
							if (_playerId) {
								_module.getPlayerInfo();
							} else {
								_module.getPlayersStatistic();
							}
							break;
						case _tabs.history:
							_module.renderHistoryData();
							break;
						default:
							_module.getCommandsStatistic();
							break;
					}
				});

				//Профиль игрока
				$_mainContainer.on('click', '.stat-widget-player-profile', function (event) {
					_playerId = $(event.target).data('player-id');
					_module.renderPlayerInfo();
				});

				//Инфа по игре
				$_mainContainer.on('click', '.stat-widget-show-game-info', function (event) {
					_gameId = $(event.target).data('game-id');
					_module.renderGameInfo();
				});
			},

			goToLink: function() {
				var gameId = _module.getUrlParameter(_gameLink);
				var playerId = _module.getUrlParameter(_playerLink);
				if (gameId) {
					_gameId = gameId;
					_module.renderGameInfo();
				} else if (playerId) {
					_playerId = playerId;
					_module.renderPlayerInfo();
				}
			},

			getUrlParameter: function(sParam) {
				var sPageURL = decodeURIComponent(window.location.search.substring(1)),
					sURLVariables = sPageURL.split('&'),
					sParameterName,
					i;

				for (i = 0; i < sURLVariables.length; i++) {
					sParameterName = sURLVariables[i].split('=');

					if (sParameterName[0] === sParam) {
						return sParameterName[1] === undefined ? true : sParameterName[1];
					}
				}
			},

			setDomenName: function () {
				if (location.hostname !== 'statistic.ru' &&
					location.hostname !== '127.0.0.1'
				) {
					_domenName = 'http://statistics.ivanshi.ru';
				}
			},

			renderWidget: function () {
				var html = _module.getWidgetHtml();
				$_mainContainer.append(html);
				_module.renderGamesStatistic();
			},

			renderSeasons: function () {
				_module.getAllSeasons();
			},

			renderCommandsStatistic: function () {
				_module.getCommandsStatistic();
			},

			renderHistoryData: function () {
				_module.getHistoryData();
			},

			renderTournaments: function () {
				var html = '';
				$.each(TOURNAMENTS_CONFIG[_seasonId], function(idx, val) {
					var active = '';
					if (idx == 0) {
						active = 'active';
						_tournamentIds = [val.id];
					}

					html +=	'<li class="stat-widget-filter-tournament ' + active + '" data-tournament-id="' + val.id + '" >' + val.name + '</li>';
				});

				html += '<li class="stat-widget-filter-tournament" data-tournament-id="' + ALL_TOURNAMENTS_ALIAS + '">Все игры сезона</li>';

				$('.stat-widget-filter-tournaments').empty().append(html);
			},

			renderHistoryTournaments: function (tournaments) {
				var optionsHtml = '';
				$.each(tournaments, function(idx, val) {
					optionsHtml +=	'<option value="' + val.tournament_id + '">' + val.name + '</option>';
				});
				optionsHtml +=	'<option value="' + ALL_TOURNAMENTS_ALIAS + '">Все игры сезона</option>';

				var html = (
					'<li>' +
						'<select class="stat-widget-filter-histoty-tournament">' +
							optionsHtml +
						'</select>' +
					'<li>'
				);

				$('.stat-widget-filter-tournaments').append(html);
			},

			renderHistoryTabs: function () {
				var html = (
					'<ul class="stat-widget-history-tabs">' +
						'<li class="stat-widget-history-tab active" data-history-tab="tables">Таблицы</li>' +
						'<li class="stat-widget-history-tab" data-history-tab="records">Рекорды</li>' +
						'<li class="stat-widget-history-tab" data-history-tab="total">Суммарные показатели</li>' +
					'</ul>'
				);

				$('.stat-widget-history-sections').append(html);
			},

			renderGamesStatistic: function () {
				var html = (
					'<div class="stat-widget-wrap-stat">' +
					_module.getFiltersHtml() +
					'<div class="stat-season-table"></div>' +
					'<div class="stat-widget-title">Игры</div>' +
					'<div class="stat-games-table"></div>' +
					'<div class="stat-widget-info">Euroleague — европейский баскетбольный турнир среди профессиональных мужских клубов из стран, являющихся членами ФИБА Европа.' +
					'<br /><br />' +
					'* В соответствии с Регламентом Евролиги 2018/2019 гг., все очки, набранные в овертайме(ах), не будут учитываться в турнирной таблице, а также для любой ситуации тай-брейков.<div class="stat-widget-info-link"><a target="_blank" href="http://www.euroleague.net/main/standings">http://www.euroleague.net/main/standings</a></div>' +
					'</div>' +
					'</div>'
				);

				$('.stat-widget-data').empty().append(html);
				_module.renderTournaments();
				_module.renderSeasons();
				_module.renderCommandsStatistic();
			},

			renderPlayersStatistic: function () {
				var html = (
					'<div class="stat-widget-wrap-stat">' +
						_module.getFiltersHtml() +
						'<div class="stat-widget-title">Статистика игроков в соревновании</div>' +
						'<div class="stat-players-table"></div>' +
					'</div>'
				);
				$('.stat-widget-data').empty().append(html);
				_module.renderTournaments();
				_module.renderSeasons();
				_module.getPlayersStatistic();
			},

			renderPlayerInfo: function () {
			    var url = window.location.href;
                url = url.split('?')[0];

				var html = (
					'<div class="stat-widget-wrap-stat">' +
						_module.getFiltersHtml() +
						'<div class="stat-widget-title"></div>' +
						'<div class="stat-widget-player-info"></div>' +
						'<div class="stat-widget-player-statistic"></div>' +
						'<div class="stat-widget-player-games-statistic"></div>' +
                        '<div class="stat-widget-copy-link">Ссылка на профиль' +
                            '<input class="stat-widget-copy-link-edit" type="text" value="' + url + '?' + _playerLink + '=' + _playerId + '" disabled/>' +
                        '</div>' +
					'</div>'
				);
				$('.stat-widget-data').empty().append(html);

				_module.renderTournaments();
				_module.renderSeasons();
				_module.getPlayerInfo();

				_activeTabId = _tabs.players;
				$('.stat-widget-tab').removeClass('active');
				$('.stat-widget-tab-players').addClass('active');
			},

			renderGameInfo: function () {
                var url = window.location.href;
                url = url.split('?')[0];

				var html = (
					'<div class="stat-widget-wrap-stat">' +
						'<div class="stat-widget-title"></div>' +
						'<div class="stat-widget-game-info"></div>' +
						'<div class="stat-widget-copy-link">Ссылка на отчет' +
                            '<input class="stat-widget-copy-link-edit" type="text" value="' + url + '?' + _gameLink + '=' + _gameId + '" disabled/>' +
                        '</div>' +
					'</div>'
				);
				$('.stat-widget-data').empty().append(html);

				_module.getGameInfo();
				$('.stat-widget-tab').removeClass('active');
				$('.stat-widget-tab-team').addClass('active');
			},

			renderHistory: function () {
				var html = (
					'<div class="stat-widget-wrap-stat">' +
						_module.getFiltersHtml() +
						'<div class="stat-widget-history-sections"></div>' +
						'<div class="stat-widget-title"></div>' +
						'<div class="stat-widget-history-content">' +
							'<div class="stat-widget-history-data stat-widget-history-data-tables">' +
								'<div class="stat-widget-history-table"></div>' +
								'<div class="stat-widget-history-team-total-table"></div>' +
							'</div>' +
							'<div class="stat-widget-history-data stat-widget-history-data-records hide"></div>' +
							'<div class="stat-widget-history-data stat-widget-history-data-total hide"></div>' +
						'</div>' +
					'</div>'
				);

				$('.stat-widget-data').empty().append(html);

				_tournamentIds = [1];
				_module.getTournaments();
				_module.renderSeasons();
				_module.renderHistoryTabs();
				_module.renderHistoryData();
			},

			getAllSeasons: function () {
				var url = _domenName + '/statistics/getAllSeasons';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.appendHtmlSeasons(response.allSeasons);
				});
			},

			getTournaments: function () {
				//_module.showLoader();
				var url = _domenName + '/statistics/getTournaments';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					//_module.hideLoader();
					_module.renderHistoryTournaments(response.tournaments);
				});
			},

			getCommandsStatistic: function () {
				_module.showLoader();
				var url = _domenName + '/statistics/getCommandsStatistic';
				var ajaxParams = {
					seasonId: _seasonId,
					tournamentIds: _tournamentIds
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					//_module.appendHtmlSeasonStatistic(response.seasonsStatistic);
					_module.appendHtmlGames(response.gamesData);
				});
			},

			getPlayersStatistic: function () {
				_module.showLoader();
				var url = _domenName + '/statistics/getPlayersStatistic';
				var ajaxParams = {
					seasonId: _seasonId,
					tournamentIds: _tournamentIds
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					//_module.appendHtmlSeasonStatistic(response.seasonsStatistic);
					_module.appendHtmlPlayersStatistic(response.playersStatistic);
				});
			},

			getPlayerInfo: function () {
				_module.showLoader();
				var url = _domenName + '/statistics/getPlayerData';
				var ajaxParams = {
					playerId: _playerId,
					seasonId: _seasonId,
					tournamentIds: _tournamentIds
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					_module.appendHtmlPlayerInfo(response.playerInfo);
					_module.appendHtmlPlayerStatistic(response.playerStatistic);
					_module.appendHtmlPlayerGamesStatistic(response.playerGamesStatistic);
				});
			},
			
			getGameInfo: function () {
				_module.showLoader();
				var url = _domenName + '/statistics/getGameInfo';
				var ajaxParams = {
					gameId: _gameId
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					_module.appendHtmlGameInfo(response.gameInfo);
				});
			},

			getHistoryData: function () {
				_module.showLoader();
				var url = _domenName + '/statistics/getHistoryData';
				var ajaxParams = {
					seasonId: _seasonId,
					tournamentIds: _tournamentIds
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					_module.appendHtmlHistoryData(response);
				});
			},

			getWidgetHtml: function () {
				return (
					'<div class="stat-widget-container﻿">' +
					'<div class="stat-widget-wrap-main">' +
					'<ul class="stat-widget-tabs">' +
					'<li class="stat-widget-tab stat-widget-tab-team active" data-tab-id="1">КОМАНДНАЯ СТАТИСТИКА</li>' +
					'<li class="stat-widget-tab stat-widget-tab-players" data-tab-id="2">ИГРОКИ</li>' +
					'<li class="stat-widget-tab stat-widget-tab-history" data-tab-id="3">ИСТОРИЯ</li>' +
					'</ul>' +
					'<div class="stat-widget-data"></div>' +
					'</div>' +
					'</div>'
				);
			},

			getFiltersHtml: function () {
				return (
					'<div class="stat-widget-filters">' +
						'<ul class="stat-widget-filter-tournaments"></ul>' +
					'</div>'
				);
			},

			appendHtmlSeasons: function (seasons) {
				var optionsHtml = '';
				$.each(seasons, function(idx, val) {
				    var selected = '';
				    if (_playerId && _seasonId == val.season_id) {
                        selected = 'selected';
                    }

					optionsHtml +=	'<option ' + selected + ' value="' + val.season_id + '">' + val.name + '</option>';
				});

				var html = (
					'<ul>' +
						'<li>' +
							'<select class="stat-widget-filter-season">' +
								optionsHtml +
							'</select>' +
						'</li>' +
					'</ul>'
				);

				$('.stat-widget-filters').append(html);
			},

			/**
			 * Статистика сезона на первой вкладке
			 */
			appendHtmlSeasonStatistic: function (data) {
				var html = (
					'<div class="stat-widget-title"></div>' +
					'<table class="stat-widget-season-statistic-table">' +
						'<colgroup>' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
							'<col width="60" />' +
						'</colgroup>' +
						'<tbody>' +
							'<tr>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2+3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ШТР</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head">РП</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head">ПТ</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head">ПХ</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">БШ</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head">ЭФФ</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head">О</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head-end">РАЗН</th>' +
							'</tr>' +
							'<tr>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">иг</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">на</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-season-statistic-table-cell-end">' + data.max_turnover + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">иг</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">на</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.min_plus_minus + '</td>' +
							'</tr>' +
							'<tr>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_two_point_made + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_two_point_throw + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_two_point_percent + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_three_point_made + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_three_point_throw + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_three_point_percent + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_two_three_point_made + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_two_three_point_throw + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_two_three_point_percent + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_free_made + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_free_throw + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_free_percent + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_offensive_rebound + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_deffensive_rebound + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_sum_rebound + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_assists + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_commited_foul + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_recieved_foul + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.min_turnover + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_steal + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_in_fawor + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_against + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_effectiveness + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.max_points_scored + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell">' + data.max_plus_minus + '</td>' +
							'</tr>' +
						'</tbody>' +
					'</table>'
				);

				$('.stat-season-table').empty();
				if (_tournamentIds.length === 1 && data.max_two_point_made !== null) {
					$('.stat-season-table').append(html);
				}
			},

			/**
			 * Матчи на первой вкладке
			 */
			appendHtmlGames: function (data) {
				var rows = '';
				$.each(data, function(idx, val) {
					rows += (
						'<tr>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' + val.dt + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center stat-widget-game-tournament-cell">' + val.tournament + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' +
								'<a class="stat-widget-game-statistic-team-logo"' +
									'target="_blank"' +
									'href="' + val.url + '"' +
									'style="background:url(' + val.logo_url + ') left center no-repeat;"' +
								'>' +
									val.opponent +
								'</a>' +
                                '<a class="stat-widget-game-statistic-team-name"' +
                                    'target="_blank"' +
                                    'href="' + val.url + '"' +
                                '>' +
                                    val.opponent +
                                '</a>' +
							'</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center stat-widget-game-venue-cell">' + val.venue + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center stat-widget-show-game-info stat-widget-link" data-game-id="' + val.game_id + '">' + val.score + '</td>' +
						'</tr>'
					);
				});
				var html = (
					'<table class="stat-widget-game-statistic-table">' +
						'<colgroup>' +
							'<colgroup>' +
								'<col width="15%" />' +
								'<col width="40%" />' +
								'<col width="15%" />' +
								'<col width="15%" />' +
								'<col width="15%" />' +
							'</colgroup>' +
						'</colgroup>' +
						'<tr>' +
							'<th class="stat-widget-game-statistic-table-cell-left">ДАТА</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center stat-widget-game-tournament-cell">ТУРНИР</th>' +
							'<th class="stat-widget-game-statistic-table-cell-left">СОПЕРНИК</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center stat-widget-game-venue-cell" title="Дома или в гостях">МЕСТО</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center">СЧЁТ</th>' +
						'</tr>' +
						rows +
					'</table>'
				);

				$('.stat-games-table').empty().append(html);
			},



			appendHtmlPlayersStatistic: function (data) {
				var rows = '';
				$.each(data, function(idx, val) {
					var avatar = val.avatar_src ? val.avatar_src : '/images/player_avatars/empty.jpg';
					var fullName = val.name + ' ' + val.surname;
					rows += (
						'<tr>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.number + '</td>' +
							'<td class="stat-widget-player-statistic-table-cell stat-widget-player-avatar-cell">' +
								'<img src="' + _domenName + avatar + '" alt="' + fullName + '" width="50" title="' + fullName + '">' +
							'</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' +
								'<span class="stat-widget-link stat-widget-player-profile" data-player-id="' + val.player_id + '">' + fullName + '</span>' +
							'</td>' +
							'<td class="stat-widget-player-statistic-table-cell stat-widget-player-birthday-cell">' + val.birthdate + '</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.position + '</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.height + ' cm</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.weight + ' kg</td>' +
						'</tr>'
					);
				});

				var html = (
					'<table class="stat-widget-game-statistic-table">' +
						'<colgroup>' +
							'<colgroup>' +
								'<col width="15%" />' +
								'<col width="15%" />' +
								'<col width="30%" />' +
								'<col width="20%" />' +
								'<col width="10%" />' +
								'<col width="10%" />' +
							'</colgroup>' +
						'</colgroup>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Номер</th>' +
							'<th class="stat-widget-player-statistic-table-cell stat-widget-player-avatar-cell">&nbsp;</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Имя</th>' +
							'<th class="stat-widget-player-statistic-table-cell stat-widget-player-birthday-cell">Дата рождения</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Позиция</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Рост</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Вес</th>' +
						'</tr>' +
						rows +
					'</table>'
				);
				
				$('.stat-players-table').empty().append(html);
			},

			appendHtmlPlayerInfo: function (data) {
				var avatar = data.avatar_src ? data.avatar_src : '/images/player_avatars/empty.jpg';
				var fullName = data.name + ' ' + data.surname;

				var html = (
					'<div class="stat-widget-player-info-img">' +
						'<img src="' + _domenName + avatar + '" alt="' + fullName + '" title="' + fullName + '" width="120px">' +
					'</div>' +
					'<table class="stat-widget-game-player-statistic-table">' +
						'<colgroup>' +
							'<col width="30%" />' +
							'<col width="70%" />' +
						'</colgroup>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Номер</th>' +
							'<td class="stat-widget-player-statistic-table-cell">' + data.number + '</td>' +
						'</tr>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Дата рождения</th>' +
							'<td class="stat-widget-player-statistic-table-cell">' + data.birthdate + '</td>' +
						'</tr>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Позиция</th>' +
							'<td class="stat-widget-player-statistic-table-cell">' + data.position + '</td>' +
						'</tr>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Рост</th>' +
							'<td class="stat-widget-player-statistic-table-cell">' + data.height + ' cm</td>' +
						'</tr>' +
						'<tr>' +
							'<th class="stat-widget-player-statistic-table-cell">Вес</th>' +
							'<td class="stat-widget-player-statistic-table-cell">' + data.weight + ' kg</td>' +
						'</tr>' +
					'</table>'
				);

				$('.stat-widget-title').empty().append(fullName);
				$('.stat-widget-player-info').empty().append(html);
			},

            appendHtmlPlayerStatistic: function (data) {
                var adaptiveHtml = 'Нет данных';
				if (data.MAX_seconds !== null) {
					var html = _module.getPlayerStatisticHtml(data);
					adaptiveHtml = (
						'<div class="stat-widget-table-first">' + html + '</div>' +
						'<div class="stat-widget-table-second">' + html + '</div>'
					);
				}

                $('.stat-widget-player-statistic').empty().append(adaptiveHtml);
            },

			getPlayerStatisticHtml: function (data) {
				var rows = '';
				var cnt = 0;
				var titles = ['SUM', 'MAX', 'AVG'];
				var titlesAlias = ['СУММ', 'МАКС', 'СРЕДН'];
				$.each(titles, function(idx, val) {
					rows += (
						'<tr>' +
                            '<th class="stat-widget-season-statistic-table-cell-end stat-widget-game-statistic-table-name stat-widget-table-first-column">' + titlesAlias[cnt] + '</th>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_player_time'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_two_point_made'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_two_point_throw'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_three_point_made'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_three_point_throw'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + (parseInt(data[titles[cnt] + '_two_point_made']) + parseInt(data[titles[cnt] + '_three_point_made'])) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(data[titles[cnt] + '_two_point_throw']) + parseInt(data[titles[cnt] + '_three_point_throw'])) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_free_made'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_free_throw'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_offensive_rebound'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_deffensive_rebound'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(data[titles[cnt] + '_offensive_rebound']) + parseInt(data[titles[cnt] + '_deffensive_rebound'])) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_assists'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_commited_foul'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_recieved_foul'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_turnover'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_steal'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_in_fawor'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_against'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_effectiveness'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data[titles[cnt] + '_plus_minus'] + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data[titles[cnt] + '_points_scored'] + '</td>' +
						'</tr>'
					);
					cnt++;
				});
				var html = (
					'<table class="stat-widget-season-statistic-table">' +
						'<colgroup>' +
							'<col width="70" />' +
							'<col width="60" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
						'</colgroup>' +
						'<tbody>' +
							'<tr class="stat-widget-table-head-row">' +
								'<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2+3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">ШТР</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head-end"></th>' +
							'</tr>' +
							'<tr class="stat-widget-table-head-row">' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column"></td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">мин</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>' +
							'</tr>' + rows +
						'</tbody>' +
					'</table>'
				);

				return html;
			},

            appendHtmlPlayerGamesStatistic: function (data) {
				var adaptiveHtml = '';
				if (data.length > 0) {
					var html = _module.getPlayerGamesStatisticHtml(data);
					adaptiveHtml = (
						'<div class="stat-widget-table-first">' + html + '</div>' +
						'<div class="stat-widget-table-second stat-widget-table-second-stretch">' + html + '</div>'
					);
				}

                $('.stat-widget-player-games-statistic').empty().append(adaptiveHtml);
            },

			getPlayerGamesStatisticHtml: function (data) {
				var rows = '';
				$.each(data, function(idx, val) {
					rows += (
						'<tr class="stat-widget-table-row-stretch">' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-game-statistic-table-name stat-widget-table-first-column">' +
								'<span class="stat-widget-show-game-info stat-widget-link" data-game-id="' + val.game_id + '">' + val.team_name + '</span>' +
								'<span class="stat-widget-game-statistic-table-dt">' + val.dt + '</span>' +
							'</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.player_time + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_point_made + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.two_point_throw + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.three_point_made + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.three_point_throw + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + (parseInt(val.two_point_made) + parseInt(val.three_point_made)) + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.two_point_throw) + parseInt(val.three_point_throw)) + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.free_made + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.free_throw + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.offensive_rebound + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.deffensive_rebound + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.offensive_rebound) + parseInt(val.deffensive_rebound)) + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.assists + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.commited_foul + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.recieved_foul + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.turnover + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.steal + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.in_fawor + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.against + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.effectiveness + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.plus_minus + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.points_scored + '</td>' +
						'</tr>'
					);
				});
				var html = (
					'<table class="stat-widget-season-statistic-table">' +
						'<colgroup>' +
							'<col width="70" />' +
							'<col width="60" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
						'</colgroup>' +
						'<tbody>' +
						'<tr class="stat-widget-table-head-row stat-widget-table-row-stretch">' +
							'<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2-ОЧК</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">3-ОЧК</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2+3-ОЧК</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">ШТР</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'<th class="stat-widget-season-statistic-table-cell-head-end"></th>' +
						'</tr>' +
						'<tr class="stat-widget-table-head-row stat-widget-table-row-stretch">' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column"></td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">мин</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>' +
							'<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>' +
						'</tr>' + rows +
						'</tbody>' +
					'</table>'
				);

				return html;
			},

            appendHtmlGameInfo: function (data) {
                var html = _module.getGameInfoHtml(data);
                var adaptiveHtml = (
                    '<div class="stat-widget-table-first">' + html + '</div>' +
                    '<div class="stat-widget-table-second">' + html + '</div>'
                );
                var title = 'ХИМКИ - ' + data['player'][0].team_name + ' / ' + data['player'][0].score + ' / ' + data['player'][0].dt;
                $('.stat-widget-title').empty().append(title);
                $('.stat-widget-game-info').empty().append(adaptiveHtml);
            },

			getGameInfoHtml: function (data) {
				var rows = '';
				$.each(data.player, function(idx, val) {
					var fullName = val.name + ' ' + val.surname;
					rows += (
						'<tr>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-game-statistic-table-name stat-widget-table-first-column">' +
								'<span class="stat-widget-link stat-widget-player-profile" data-player-id="' + val.player_id + '">' + fullName + '</span>' +
							'</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.player_time + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_point_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.two_point_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.three_point_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.three_point_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + (parseInt(val.two_point_made) + parseInt(val.three_point_made)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.two_point_throw) + parseInt(val.three_point_throw)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.free_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.free_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.offensive_rebound + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.deffensive_rebound + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.offensive_rebound) + parseInt(val.deffensive_rebound)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.assists + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.commited_foul + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.recieved_foul + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.turnover + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.steal + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.in_fawor + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.against + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.effectiveness + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.plus_minus + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.points_scored + '</td>' +
						'</tr>'
					);
				});
				var html = (
					'<table class="stat-widget-season-statistic-table">' +
						'<colgroup>' +
							'<col width="70" />' +
							'<col width="60" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
							'<col width="50" />' +
						'</colgroup>' +
						'<tbody>' +
							'<tr class="stat-widget-table-head-row">' +
								'<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2+3-ОЧК</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">ШТР</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
								'<th class="stat-widget-season-statistic-table-cell-head-end"></th>' +
							'</tr>' +
							'<tr class="stat-widget-table-head-row">' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column"></td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">мин</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>' +
							'</tr>' + rows +
							'<tr>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-game-statistic-table-name stat-widget-table-first-column">Сумма</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum'].player_time + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum'].two_point_made + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['two_point_throw'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['three_point_made'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['three_point_throw'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + (parseInt(data['sum']['two_point_made']) + parseInt(data['sum']['three_point_made'])) + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(data['sum']['two_point_throw']) + parseInt(data['sum']['three_point_throw'])) + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['free_made'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['free_throw'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['offensive_rebound'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['deffensive_rebound'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(data['sum']['offensive_rebound']) + parseInt(data['sum']['deffensive_rebound'])) + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['assists'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['commited_foul'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['recieved_foul'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['turnover'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['steal'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['in_fawor'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['against'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['effectiveness'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + data['sum']['plus_minus'] + '</td>' +
								'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + data['sum']['points_scored'] + '</td>' +
							'</tr>' +
						'</tbody>' +
					'</table>'
				);

				return html;
			},

            appendHtmlHistoryTotal: function (data) {
                var html = _module.getHistoryTotalHtml(data);
                var adaptiveHtml = (
                    '<div class="stat-widget-table-first">' + html + '</div>' +
                    '<div class="stat-widget-table-second">' + html + '</div>'
                );

                $('.stat-widget-history-data-total').empty().append(adaptiveHtml);
				$('.stat-widget-sortable-table').tablesorter();
            },

            getHistoryTotalHtml: function (data) {
                var rows = '';
                $.each(data, function(idx, val) {
                    var fullName = val.name + ' ' + val.surname;
                    rows += (
                        '<tr>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-game-statistic-table-name stat-widget-table-first-column">' +
                                '<span class="stat-widget-link stat-widget-player-profile" data-player-id="' + val.player_id + '">' + fullName + '</span>' +
                            '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.player_time + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_point_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.two_point_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.three_point_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.three_point_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + (parseInt(val.two_point_made) + parseInt(val.three_point_made)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.two_point_throw) + parseInt(val.three_point_throw)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.free_made + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.free_throw + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.offensive_rebound + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.deffensive_rebound + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + (parseInt(val.offensive_rebound) + parseInt(val.deffensive_rebound)) + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.assists + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.commited_foul + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.recieved_foul + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.turnover + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.steal + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.in_fawor + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.against + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.effectiveness + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.plus_minus + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.points_scored + '</td>' +
                        '</tr>'
                    );
                });
                var html = (
                    '<table class="stat-widget-season-statistic-table stat-widget-sortable-table">' +
                        '<colgroup>' +
                            '<col width="70" />' +
                            '<col width="60" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                            '<col width="50" />' +
                        '</colgroup>' +
						'<thead>' +
                            '<tr class="stat-widget-table-head-row">' +
                                '<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2-ОЧК</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2">3-ОЧК</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2">2+3-ОЧК</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2">ШТР</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head"></th>' +
                                '<th class="stat-widget-season-statistic-table-cell-head-end"></th>' +
                            '</tr>' +
                            '<tr class="stat-widget-table-head-row">' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column"></td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">мин</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Б</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>' +
                                '<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>' +
                            '</tr>' +
						'</thead>' +
						'</tbody>' +
                            rows +
                        '</tbody>' +
                    '</table>'
                );

                return html;
            },

			appendHtmlHistoryData: function (data) {
				_module.appendHtmlHistoryTables(data.historyTables);
				_module.appendHtmlHistoryRecords(data.historyRecords);
				_module.appendHtmlHistoryTotal(data.historyTotal);
			},

			appendHtmlHistoryTables: function (historyTables) {
				$('.stat-widget-history-table').empty();
				$('.stat-widget-history-team-total-table').empty()
				if (!historyTables.history.length && !historyTables.history_teams_total.length) {
					$('.stat-widget-history-table').append('Нет данных');
				} else {
					_module.appendHtmlHistory(historyTables.history);
					_module.appendHtmlTeamHistory(historyTables.history_teams_total);
				}
			},

			appendHtmlHistory: function (history) {
				var rows = '';
				$.each(history, function(idx, val) {
					rows += (
						'<tr>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' + val.dt + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' +
								'<a class="stat-widget-game-statistic-team-logo"' +
									'target="_blank"' +
									'href="' + val.team_url_one + '"' +
									'style="background:url(' + val.team_logo_url_one + ') left center no-repeat;"' +
								'>' +
									val.team_name_one +
								'</a>' +
                                '<a class="stat-widget-game-statistic-team-name"' +
                                    'target="_blank"' +
                                    'href="' + val.team_url_one + '"' +
                                '>' +
                                    val.team_name_one +
                                '</a>' +
							'</td>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' +
								'<a class="stat-widget-game-statistic-team-logo"' +
									'target="_blank"' +
									'href="' + val.team_url_two + '"' +
									'style="background:url(' + val.team_logo_url_two + ') left center no-repeat;"' +
								'>' +
									val.team_name_two +
								'</a>' +
                                '<a class="stat-widget-game-statistic-team-name"' +
                                    'target="_blank"' +
                                    'href="' + val.team_url_two + '"' +
                                '>' +
                                    val.team_name_two +
                                '</a>' +
							'</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center">' + val.score_one + ':' + val.score_two + '</td>' +
						'</tr>'
					);
				});

				var html = '';
				if (history.length) {
					html += (
						'<table class="stat-widget-game-statistic-table">' +
						'<colgroup>' +
							'<col width="15%" />' +
							'<col width="35%" />' +
							'<col width="35%" />' +
							'<col width="15%" />' +
						'</colgroup>' +
						'<tr>' +
							'<th class="stat-widget-game-statistic-table-cell-left">ДАТА</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center"></th>' +
							'<th class="stat-widget-game-statistic-table-cell-left"></th>' +
							'<th class="stat-widget-game-statistic-table-cell-center">СЧЁТ</th>' +
						'</tr>' +
							rows +
						'</table>'
					);
				}

				$('.stat-widget-history-table').empty().append(html);
			},

			appendHtmlTeamHistory: function (historyTeamsTotal) {
				var adaptiveHtml = '';
				if (historyTeamsTotal.length) {
					var html = _module.getTeamHistoryHtml(historyTeamsTotal);
					adaptiveHtml += (
						'<div class="stat-widget-table-first">' + html + '</div>' +
						'<div class="stat-widget-table-second">' + html + '</div>'
					);
				}

				$('.stat-widget-history-team-total-table').empty().append(adaptiveHtml);
				$(".stat-widget-sortable-table").tablesorter();
			},

			getTeamHistoryHtml: function (historyTeamsTotal) {
				var rows = '';
				$.each(historyTeamsTotal, function(idx, val) {
					rows += (
						'<tr>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-first-column stat-widget-game-statistic-table-name">' +
							'<div class="stat-widget-table-adaptive-name">' + val.name + '</div>' +
						'</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_point_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_point_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.two_point_percent + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.three_point_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.three_point_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.three_point_percent + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_three_point_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.two_three_point_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.two_three_point_percent + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.free_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.free_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.free_percent + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.offensive_rebound + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.deffensive_rebound + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.sum_rebound + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.assists + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.commited_foul + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.recieved_foul + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.turnover + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.steal + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.in_fawor + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.against + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.effectiveness + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">' + val.plus_minus + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">' + val.points_scored + '</td>' +
						'</tr>'
					);
				});
				var html = (
					'<table class="stat-widget-season-statistic-table stat-widget-sortable-table">' +
					'<colgroup>' +
					'<col width="70" />' +
					'<col width="60" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'<col width="50" />' +
					'</colgroup>' +
					'<thead>' +
					'<tr class="stat-widget-table-head-row">' +
					'<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2-ОЧК</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">3-ОЧК</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2+3-ОЧК</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ШТР</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>' +
					'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
					'<th class="stat-widget-season-statistic-table-cell-head-end"></th>' +
					'</tr>' +

					'<tr class="stat-widget-table-head-row">' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column">Команда</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">З</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Б</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">С</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>' +
						'<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>' +
					'</tr>' +
					'</thead>' +
					'<tbody>' +
					rows +
					'</tbody>' +
					'</table>'
				);

				return html;
			},

			appendHtmlHistoryRecords: function (historyRecords) {
				var rowsGames = '';
				$.each(historyRecords.games, function(category, val) {
					rowsGames += (
						'<tr>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-record-cell-left">' + historyRecords.games[category].alias + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-record-cell-left">' + historyRecords.games[category].dt + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell stat-widget-record-cell-left stat-widget-show-game-info stat-widget-link" data-game-id="' + historyRecords.games[category].game_id + '">' + historyRecords.games[category].opponent + '</td>' +
							'<td class="stat-widget-season-statistic-table-cell">' + historyRecords.games[category][category] + '</td>' +
						'</tr>'
					);
				});

                var rowsPlayers = '';
                $.each(historyRecords.players, function(category, val) {
                    var fullName = historyRecords.players[category].name + ' ' + historyRecords.players[category].surname;
                    rowsPlayers += (
                        '<tr>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-record-cell-left">' + historyRecords.players[category].alias + '</td>' +
                            '<td class="stat-widget-season-statistic-table-cell stat-widget-record-cell-left">' +
								'<span class="stat-widget-link stat-widget-player-profile" data-player-id="' + historyRecords.players[category].player_id + '">' + fullName + '</span>' +
							'</td>' +
                            '<td class="stat-widget-season-statistic-table-cell">' + historyRecords.players[category][category] + '</td>' +
                        '</tr>'
                    );
                });

				var html = (
					'<div class="stat-widget-records-comand">' +
						'<div class="stat-widget-records-title">Рекорды команды</div>' +
						'<table class="stat-widget-season-statistic-table">' +
							'<colgroup>' +
								'<col width="50" />' +
								'<col width="50" />' +
								'<col width="100" />' +
								'<col width="65" />' +
								'</colgroup>' +
							'<tbody>' +
								'<tr>' +
									'<th class="stat-widget-season-statistic-table-cell-head-end stat-widget-record-cell-left">Категория</th>' +
									'<th class="stat-widget-season-statistic-table-cell-head-end stat-widget-record-cell-left">Дата</th>' +
									'<th class="stat-widget-season-statistic-table-cell-head-end stat-widget-record-cell-left">Соперник</th>' +
									'<th class="stat-widget-season-statistic-table-cell-head-end">Результат</th>' +
								'</tr>' +
								rowsGames +
							'</tbody>' +
						'</table>' +
					'</div>' +
					'<div class="stat-widget-records-players">' +
						'<div class="stat-widget-records-title">Рекорды игроков</div>' +
                        '<table class="stat-widget-season-statistic-table">' +
                            '<colgroup>' +
                                '<col width="200" />' +
                                '<col width="400" />' +
                                '<col width="200" />' +
                            '</colgroup>' +
                            '<tbody>' +
                                '<tr>' +
                                    '<th class="stat-widget-season-statistic-table-cell-head-end stat-widget-record-cell-left">Категория</th>' +
                                    '<th class="stat-widget-season-statistic-table-cell-head-end stat-widget-record-cell-left">Игрок</th>' +
                                    '<th class="stat-widget-season-statistic-table-cell-head-end">Результат</th>' +
                                '</tr>' +
                                rowsPlayers +
                            '</tbody>' +
                        '</table>' +
					'</div>'
				);

				$('.stat-widget-history-data-records').empty().append(html);

			},

			showLoader: function () {
				var loaderHtml = (
					'<div class="stat-loader"' +
						'style="' +
							'position:absolute;' +
							'top:520px;' +
							'left:50%;' +
							'margin-left:-64px;' +
							'width:300px;' +
							'z-index:3;' +
							'">' +
						'<img src="' + _domenName + '/images/loader.gif" />' +
					'</div>'
				);
				$('.stat-widget-data').css('opacity', '0.5');
				$('.stat-widget-data').append(loaderHtml);
			},
			
			hideLoader: function () {
				$('.stat-widget-data').css('opacity', '1');
				$('.stat-loader').remove();
			}
		};
	})(jQuery);
})(jQuery);
