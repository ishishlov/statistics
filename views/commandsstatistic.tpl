{% include 'tempheader.tpl' %}
<link rel="stylesheet" href="/css/style.css" />
<div id="stat-widget">
	{#
	<div class="stat-widget-container﻿">
		<div class="stat-widget-wrap-main">
			<ul class="stat-widget-tabs">
				<li class="stat-widget-tab active">КОМАНДНАЯ СТАТИСТИКА</li>
				<li class="stat-widget-tab">ИГРОКИ</li>
				<li class="stat-widget-tab">ИСТОРИЯ</li>
			</ul>
			<div class="stat-widget-wrap-stat">
				<div class="stat-widget-filters">
					<ul class="stat-widget-filter-tournaments">
						<li class="stat-widget-filter-tournament active">Евролига</li>
						<li class="stat-widget-filter-tournament">Единая Лига ВТБ</li>
						<li class="stat-widget-filter-tournament">Все игры сезона</li>
					</ul>
					<ul>
						<li>
							<select class="stat-widget-filter-season">
								{% for season in allSeasons %}
									<option value="{{ season.season_id }}">{{ season.name }}</option>
								{% endfor %}
							</select>
						</li>
					</ul>
				</div>
				<div class="stat-widget-title">Статистика сезона в соревновании</div>
				<table class="stat-widget-season-statistic-table">
					<colgroup>
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
						<col width="60" />
					</colgroup>
					<tbody>
						<tr>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2-ОЧК</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="3">3-ОЧК</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2+3-ОЧК</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ШТР</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>
							<th class="stat-widget-season-statistic-table-cell-head">РП</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>
							<th class="stat-widget-season-statistic-table-cell-head">ПТ</th>
							<th class="stat-widget-season-statistic-table-cell-head">ПХ</th>
							<th class="stat-widget-season-statistic-table-cell-head" colspan="2">БШ</th>
							<th class="stat-widget-season-statistic-table-cell-head">ЭФФ</th>
							<th class="stat-widget-season-statistic-table-cell-head">О</th>
							<th class="stat-widget-season-statistic-table-cell-head">ОП</th>
							<th class="stat-widget-season-statistic-table-cell-head-end">РАЗН</th>
						</tr>
						<tr>
							<td class="stat-widget-season-statistic-table-cell-bold">З</td>
							<td class="stat-widget-season-statistic-table-cell-bold">Б</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>
							<td class="stat-widget-season-statistic-table-cell-bold">З</td>
							<td class="stat-widget-season-statistic-table-cell-bold">Б</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>
							<td class="stat-widget-season-statistic-table-cell-bold">З</td>
							<td class="stat-widget-season-statistic-table-cell-bold">Б</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>
							<td class="stat-widget-season-statistic-table-cell-bold">З</td>
							<td class="stat-widget-season-statistic-table-cell-bold">Б</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">%</td>
							<td class="stat-widget-season-statistic-table-cell-bold">Ч</td>
							<td class="stat-widget-season-statistic-table-cell-bold">С</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">В</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
							<td class="stat-widget-season-statistic-table-cell-bold">иг</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">на</td>
							<td class="stat-widget-season-statistic-table-cell stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_turnover }}</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
							<td class="stat-widget-season-statistic-table-cell-bold">иг</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">на</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
							<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
							<td class="stat-widget-season-statistic-table-cell stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_op }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.min_plus_minus }}</td>
						</tr>
						<tr>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_two_point_made }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_two_point_throw }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_two_point_percent }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_three_point_made }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_three_point_throw }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_three_point_percent }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_two_three_point_made }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_two_three_point_throw }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_two_three_point_percent }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_free_made }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_free_throw }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_free_percent }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_offensive_rebound }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_deffensive_rebound }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_sum_rebound }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_assists }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_commited_foul }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_recieved_foul }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.min_turnover }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_steal }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_in_fawor }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_against }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_effectiveness }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_points_scored }}</td>
							<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.min_op }}</td>
							<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_plus_minus }}</td>
						</tr>
					</tbody>
				</table>
				<div class="stat-widget-title">Игры</div>
				<table class="stat-widget-game-statistic-table">
					<colgroup>
						<colgroup>
							<col width="15%" />
							<col width="40%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
					</colgroup>
					<tr>
						<th class="stat-widget-game-statistic-table-cell-left">ДАТА</th>
						<th class="stat-widget-game-statistic-table-cell-center">ТУРНИР</th>
						<th class="stat-widget-game-statistic-table-cell-left">СОПЕРНИК</th>
						<th class="stat-widget-game-statistic-table-cell-center" title="Дома или в гостях">МЕСТО</th>
						<th class="stat-widget-game-statistic-table-cell-center">СЧЁТ</th>
					</tr>

					{% for stat in gamesStatistic %}
						<tr>
							<td class="stat-widget-game-statistic-table-cell-left">{{ stat.dt }}</td>
							<td class="stat-widget-game-statistic-table-cell-center">{{ stat.tournament }}</td>
							<td class="stat-widget-game-statistic-table-cell-left">
								<a class="stat-widget-game-statistic-team-logo"
								   target="_blank"
								   href="teamgames.html"
								   style="background:url({{ stat.logo_url }}) left center no-repeat;"
								>
									{{ stat.opponent }}
								</a>
							</td>
							<td class="stat-widget-game-statistic-table-cell-center">{{ stat.venue }}</td>
							<td class="stat-widget-game-statistic-table-cell-center">
								<a href="protocol.html">{{ stat.score }}</a>
							</td>
						</tr>
					{% endfor %}
				</table>
				<div class="stat-widget-info">Euroleague — европейский баскетбольный турнир среди профессиональных мужских клубов из стран, являющихся членами ФИБА Европа.
					<br /><br />
					* В соответствии с Регламентом Евролиги 2018/2019 гг., все очки, набранные в овертайме(ах), не будут учитываться в турнирной таблице, а также для любой ситуации тай-брейков.<div class="stat-widget-info-link"><a target="_blank" href="http://www.euroleague.net/main/standings">http://www.euroleague.net/main/standings</a></div>
				</div>
			</div>
		</div>
	</div>
	#}
</div>
<script type="text/javascript" src="/js/index.js"></script>
{% include 'tempfooter.tpl' %}