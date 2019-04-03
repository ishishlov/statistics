(function($) {
	$(function() {
		statWidget.init();
	});
	var statWidget = (function() {
		var _module;
		var $_mainContainer;
		var _tournaments;
		var _tournamentIds = [2];
		var _seasonId = 17;
		var _allSeasons;
		var _tabs = {
			commandStatistic: 1,
			players: 2,
			history: 3
		};
		var _tabId = _tabs.commandStatistic;

		return {
			init: function() {
				_module = this;
				//_module.setDefaultAllSeasons();
				//_module.setTournaments();
				$_mainContainer = $('#stat-widget');
				_module.renderWidget();

				//Смена вкладки
				$_mainContainer.on('click', '.stat-widget-tab', function (event) {
					$('.stat-widget-tab').removeClass('active');
					$(event.target).addClass('active');
					_tournamentIds = [2];
					_seasonId = 17;
					_tabId = $(event.target).data('tab-id');
					switch (_tabId) {
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
					if (tournamentId == 999) {
						_tournamentIds = [1, 2];
					} else {
						_tournamentIds = [tournamentId];
					}
					switch (_tabId) {
						case _tabs.commandStatistic:
							_module.getCommandsStatistic();
							break;
						case _tabs.players:
							_module.getPlayersStatistic();
							break;
						case _tabs.history:
							
							break;
						default:
							_module.getCommandsStatistic();
							break;
					}
				});

				//Смена сезона
				$_mainContainer.on('change', '.stat-widget-filter-season', function (event) {
					_seasonId = $(event.target).val();
					switch (_tabId) {
						case _tabs.commandStatistic:
							_module.getCommandsStatistic();
							break;
						case _tabs.players:
							_module.getPlayersStatistic();
							break;
						case _tabs.history:
							
							break;
						default:
							_module.getCommandsStatistic();
							break;
					}
				});

				//Профиль игрока
				$_mainContainer.on('click', '.stat-widget-player-profile', function (event) {
					playerId = $(event.target).data('player-id');
					_module.getPlayerStatistic(playerId);
				});
			},

			renderWidget: function () {
				var html = _module.getHtmlWidget();
				$_mainContainer.append(html);
				_module.renderGamesStatistic();
			},

			renderSeasons: function () {
				_module.getAllSeasons();
			},

			renderCommandsStatistic: function () {
				_module.getCommandsStatistic();
			},

			renderTournaments: function () {
				var html = (
					'<li class="stat-widget-filter-tournament active" data-tournament-id="2" >Евролига</li>' +
					'<li class="stat-widget-filter-tournament" data-tournament-id="1">Единая Лига ВТБ</li>' +
					'<li class="stat-widget-filter-tournament" data-tournament-id="999">Все игры сезона</li>'
				);

				$('.stat-widget-filter-tournaments').append(html);
			},

			getAllSeasons: function () {
				var url = '/statistics/getAllSeasons';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.appendHtmlSeasons(response.allSeasons);
				});
			},

			getTournaments: function () {
				_module.showLoader();
				var url = '/statistics/getTournaments';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
				});
			},

			getCommandsStatistic: function () {
				_module.showLoader();
				var url = '/statistics/getCommandsStatistic';
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
					_module.appendHtmlSeasonStatistic(response.seasonsStatistic);
					_module.appendHtmlCommandsStatistic(response.gamesStatistic);
				});
			},

			getPlayersStatistic: function () {
				_module.showLoader();
				var url = '/statistics/getPlayersStatistic';
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
					_module.appendHtmlSeasonStatistic(response.seasonsStatistic);
					_module.appendHtmlPlayersStatistic(response.playersStatistic);
				});
			},

			getPlayerStatistic: function (playerId) {
				_module.showLoader();
				var url = '/statistics/getPlayerData';
				var ajaxParams = {
					playerId: playerId
				};
				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					$('.stat-widget-tab').removeClass('active');
					$('.js-stat-widget-tab-players').addClass('active');
					_module.hideLoader();
					_module.appendHtmlPlayerInfo(response.playerInfo);
					_module.appendHtmlPlayerStatistic(response.playerStatistic);
				});
			},

			appendHtmlSeasons: function (seasons) {
				var html = '';
				$.each(seasons, function(idx, val) {
					html +=	'<option value="' + val.season_id + '">' + val.name + '</option>';
				});
				$('.stat-widget-filter-season').append(html);
			},

			/**
			 * Статистика сезона на первой вкладке
			 */
			appendHtmlSeasonStatistic: function (data) {
				var html = (
					'<div class="stat-widget-title">Статистика сезона в соревновании</div>' +
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
			 * Коммандная статистика на первой вкладке
			 */
			appendHtmlCommandsStatistic: function (data) {
				var rows = '';
				$.each(data, function(idx, val) {
					rows += (
						'<tr>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' + val.dt + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center">' + val.tournament + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-left">' +
								'<a class="stat-widget-game-statistic-team-logo"' +
									'target="_blank"' +
									'href="teamgames.html"' +
									'style="background:url(' + val.logo_url + ') left center no-repeat;"' +
								'>' +
									val.opponent +
								'</a>' +
							'</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center">' + val.venue + '</td>' +
							'<td class="stat-widget-game-statistic-table-cell-center">' +
								'<a href="protocol.html">' + val.score + '</a>' +
							'</td>' +
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
							'<th class="stat-widget-game-statistic-table-cell-center">ТУРНИР</th>' +
							'<th class="stat-widget-game-statistic-table-cell-left">СОПЕРНИК</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center" title="Дома или в гостях">МЕСТО</th>' +
							'<th class="stat-widget-game-statistic-table-cell-center">СЧЁТ</th>' +
						'</tr>' +
						rows +
					'</table>'
				);

				$('.stat-games-table').empty();
				$('.stat-games-table').append(html);
			},

			getHtmlWidget: function () {
				return (
					'<div class="stat-widget-container﻿">' +
						'<div class="stat-widget-wrap-main">' +
							'<ul class="stat-widget-tabs">' +
								'<li class="stat-widget-tab active" data-tab-id="1">КОМАНДНАЯ СТАТИСТИКА</li>' +
								'<li class="stat-widget-tab" data-tab-id="2">ИГРОКИ</li>' +
								'<li class="stat-widget-tab" data-tab-id="3">ИСТОРИЯ</li>' +
							'</ul>' +
							'<div class="stat-widget-data"></div>' +
						'</div>' +
					'</div>'
				);
			},

			appendHtmlPlayersStatistic: function (data) {
				var rows = '';
				$.each(data, function(idx, val) {
					var avatar = val.avatar_src ? val.avatar_src : '/images/player_avatars/empty.jpg';
					var fullName = val.name + ' ' + val.surname;
					rows += (
						'<tr>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.number + '</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' +
								'<img src="' + avatar + '" alt="' + fullName + '" width="50" title="' + fullName + '">' +
							'</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' +
								'<span class="stat-widget-link stat-widget-player-profile" data-player-id="' + val.player_id + '">' + fullName + '</span>' +
							'</td>' +
							'<td class="stat-widget-player-statistic-table-cell">' + val.birthdate + '</td>' +
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
							'<th class="stat-widget-player-statistic-table-cell">&nbsp;</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Имя</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Дата рождения</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Позиция</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Рост</th>' +
							'<th class="stat-widget-player-statistic-table-cell">Вес</th>' +
						'</tr>' +
						rows +
					'</table>'
				);
				
				$('.stat-players-table').empty();
				$('.stat-players-table').append(html);
			},

			appendHtmlPlayerInfo: function (data) {
				var avatar = data.avatar_src ? data.avatar_src : '/images/player_avatars/empty.jpg';
				var fullName = val.name + ' ' + val.surname;

				var html = (
					'<div class="stat-widget-player-info-img">' +
						'<img src="' + avatar + '" width="120">' +
					'</div>' +
					'<table class="stat-widget-game-statistic-table" style="width:60%">' +
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
					'</table>' +
					'<div class="clearfix"></div>'
				);

				$('.js-stat-widget1-title-wrapper').empty().append(fullName);
				$('.js-stat-widget1-wrapper').empty().append(html);
				$('.js-stat-widget2-wrapper').empty();
			},

			appendHtmlPlayerStatistic: function (data) {
				var rows = '';
				var cnt = 0;
				var titles = ['SUM', 'MAX', 'AVG'];
				$.each(data, function(idx, val) {
					min = Math.floor(val.max_seconds/60);
					sec = val.max_seconds - min*60;
					if (sec < 10) sec = '0' + sec;
					rows += (
						'<tr>' +
						'<th class="stat-widget-season-statistic-table-cell-left stat-widget-season-statistic-table-cell-end">' + titles[cnt] + '</th>' +
						'<td class="stat-widget-season-statistic-table-cell-end" alt="min">' + min + ':' + sec + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.two_point_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.two_point_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.three_point_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.three_point_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + (parseInt(val.two_point_made) + parseInt(val.three_point_made)) + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + (parseInt(val.two_point_throw) + parseInt(val.three_point_throw)) + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.free_made + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.free_throw + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.offensive_rebound + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.deffensive_rebound + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + (parseInt(val.offensive_rebound) + parseInt(val.deffensive_rebound)) + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.assists + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.commited_foul + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.recieved_foul + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.turnover + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.steal + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.in_fawor + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.against + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.effectiveness + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell-end">' + val.plus_minus + '</td>' +
						'<td class="stat-widget-season-statistic-table-cell">' + val.points_scored + '</td>' +
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
							'<tr>' +
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
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
								'<th class="stat-widget-season-statistic-table-cell-head"></th>' +
							'</tr>' +
							'<tr>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end"></td>' +
								'<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">min</td>' +
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
				$('.js-stat-widget2-wrapper').empty();
				if (_tournamentIds.length === 1 && data.max_two_point_made !== null) {
					$('.js-stat-widget2-wrapper').append(html);
				}
			},

			renderGamesStatistic: function () {
				var html = (
					'<div class="stat-widget-wrap-stat">' +
						'<div class="stat-widget-filters">' +
							'<ul class="stat-widget-filter-tournaments"></ul>' +
							'<ul>' +
								'<li>' +
									'<select class="stat-widget-filter-season"></select>' +
								'</li>' +
							'</ul>' +
						'</div>' +
						'<div class="stat-season-table"></div>' +
						'<div class="stat-widget-title">Игры</div>' +
						'<div class="stat-games-table"></div>' +
						'<div class="stat-widget-info">Euroleague — европейский баскетбольный турнир среди профессиональных мужских клубов из стран, являющихся членами ФИБА Европа.' +
							'<br /><br />' +
							'* В соответствии с Регламентом Евролиги 2018/2019 гг., все очки, набранные в овертайме(ах), не будут учитываться в турнирной таблице, а также для любой ситуации тай-брейков.<div class="stat-widget-info-link"><a target="_blank" href="http://www.euroleague.net/main/standings">http://www.euroleague.net/main/standings</a></div>' +
						'</div>' +
					'</div>'
				);

				$('.stat-widget-data').empty();
				$('.stat-widget-data').append(html);
				_module.renderTournaments();
				_module.renderSeasons();
				_module.renderCommandsStatistic();
			},

			renderPlayersStatistic: function () {
				var html = (
					'<div class="stat-widget-wrap-stat">' +
						'<div class="stat-widget-filters">' +
							'<ul class="stat-widget-filter-tournaments"></ul>' +
							'<ul>' +
								'<li>' +
									'<select class="stat-widget-filter-season"></select>' +
								'</li>' +
							'</ul>' +
						'</div>' +
						'<div class="stat-widget-title">Статистика игроков в соревновании</div>' +
						'<div class="stat-players-table"></div>' +
					'</div>'
				);
				$('.stat-widget-data').empty();
				$('.stat-widget-data').append(html);
				_module.renderTournaments();
				_module.renderSeasons();
				_module.getPlayersStatistic();
			},

			renderHistory: function () {
				$('.stat-widget-data').empty();
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
						'<img src="/images/loader.gif" />' +
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
