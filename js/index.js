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
					_module.getCommandsStatistic();
				});

				//Смена сезона
				$_mainContainer.on('change', '.stat-widget-filter-season', function (event) {
					_seasonId = $(event.target).val();
					_module.getCommandsStatistic();
				});
			},

			renderWidget: function () {
				var html = _module.getHtmlWidget();
				$_mainContainer.append(html);
				_module.renderSeasons();
				_module.renderCommandsStatistic();
			},

			renderSeasons: function () {
				_module.getAllSeasons();
			},

			renderCommandsStatistic: function () {
				_module.getCommandsStatistic();
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
				var url = '/statistics/getTournaments';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					
				});
			},

			getCommandsStatistic: function () {
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
					_module.appendHtmlSeasonStatistic(response.seasonsStatistic);
					_module.appendHtmlCommandsStatistic(response.gamesStatistic);
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
								'<th class="stat-widget-season-statistic-table-cell-head">ОП</th>' +
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
								'<td class="stat-widget-season-statistic-table-cell stat-widget-season-statistic-table-cell-end">' + data.max_op + '</td>' +
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
								'<td class="stat-widget-season-statistic-table-cell-end">' + data.min_op + '</td>' +
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

				$('.stat-games-table').empty(html);
				$('.stat-games-table').append(html);
			},

			getHtmlWidget: function () {
				return (
					'<div class="stat-widget-container﻿">' +
						'<div class="stat-widget-wrap-main">' +
							'<ul class="stat-widget-tabs">' +
								'<li class="stat-widget-tab active">КОМАНДНАЯ СТАТИСТИКА</li>' +
								'<li class="stat-widget-tab">ИГРОКИ</li>' +
								'<li class="stat-widget-tab">ИСТОРИЯ</li>' +
							'</ul>' +
							'<div class="stat-widget-wrap-stat">' +
								'<div class="stat-widget-filters">' +
									'<ul class="stat-widget-filter-tournaments">' +
										'<li class="stat-widget-filter-tournament active" data-tournament-id="2" >Евролига</li>' +
										'<li class="stat-widget-filter-tournament" data-tournament-id="1">Единая Лига ВТБ</li>' +
										'<li class="stat-widget-filter-tournament" data-tournament-id="999">Все игры сезона</li>' +
									'</ul>' +
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
							'</div>' +
						'</div>' +
					'</div>'
				);
			},

			renameSection: function (data) {
				var url = '/catalog/renamesection';
				var ajaxParams = {
					sectionId: 111,
					oldSectionName: 222
				};

				$.ajax({
					url: url,
					data: ajaxParams,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					
				});
			}
		};
	})(jQuery);
})(jQuery);﻿