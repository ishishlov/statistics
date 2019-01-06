{% include 'tempheader.tpl' %}
<link rel="stylesheet" href="/css/style.css" />
<div class="stat-widget-container﻿">
	<div class="stat-widget-wrap-main">
		<ul class="stat-widget-tabs">
			<li class="stat-widget-tab">КОМАНДНАЯ СТАТИСТИКА</li>
			<li class="stat-widget-tab active">ИГРОКИ</li>
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
			<div class="stat-widget-title">Игры</div>
			<table class="stat-widget-game-statistic-table">
				<colgroup>
					<colgroup>
						<col width="30%" />
						<col width="15%" />
						<col width="5%" />
						<col width="20%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
				</colgroup>
				<tr>
					<th class="stat-widget-player-statistic-table-cell">Номер</th>
					<th class="stat-widget-player-statistic-table-cell">Имя</th>
					<th class="stat-widget-player-statistic-table-cell">Рождение</th>
					<th class="stat-widget-player-statistic-table-cell">&nbsp;</th>
					<th class="stat-widget-player-statistic-table-cell">Позиция</th>
					<th class="stat-widget-player-statistic-table-cell">Рост</th>
					<th class="stat-widget-player-statistic-table-cell">Вес</th>
				</tr>
				{% for stat in playersStatistic %}
					<tr>
						<td class="stat-widget-player-statistic-table-cell">{{ stat.number }}</td>
						<td class="stat-widget-player-statistic-table-cell"><a href="protocol.html">{{ stat.name }} {{ stat.surname }}</a></td>
						<td class="stat-widget-player-statistic-table-cell">{{ stat.birthdate }}</td>
						<td class="stat-widget-player-statistic-table-cell">
							<img src="{{ stat.logo_src }}" alt="{{ stat.alpha }}" align="absmiddle" title="{{ stat.country }}">
						</td>
						<td class="stat-widget-player-statistic-table-cell">{{ stat.position }}</td>
						<td class="stat-widget-player-statistic-table-cell">{{ stat.height }} cm</td>
						<td class="stat-widget-player-statistic-table-cell">{{ stat.weight }} kg</td>
					</tr>
				{% endfor %}
			</table>
		</div>
	</div>
	
</div>
{% include 'tempfooter.tpl' %}