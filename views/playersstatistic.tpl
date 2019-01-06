{% include 'tempheader.tpl' %}
<link rel="stylesheet" href="/css/style.css" />
<div class="stat-widget-container﻿">
	<div class="stat-widget-wrap-main">
		<div class="stat-widget-title-main">Игроки</div>
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
				<tr>
					<td class="stat-widget-player-statistic-table-cell">1</td>
					<td class="stat-widget-player-statistic-table-cell"><a href="protocol.html">Алексей Швед</a></td>
					<td class="stat-widget-player-statistic-table-cell">16/12/1988</td>
					<td class="stat-widget-player-statistic-table-cell">
						<img src="http://widgets.baskethotel.com/static/images/flags/ru.gif" alt="RU" align="absmiddle" title="Россия">
					</td>
					<td class="stat-widget-player-statistic-table-cell">Защитник</td>
					<td class="stat-widget-player-statistic-table-cell">198 cm</td>
					<td class="stat-widget-player-statistic-table-cell">86 kg</td>
				</tr>
				<tr>
					<td class="stat-widget-player-statistic-table-cell">3</td>
					<td class="stat-widget-player-statistic-table-cell"><a href="protocol.html">Ди Бост</a></td>
					<td class="stat-widget-player-statistic-table-cell">12/10/1989</td>
					<td class="stat-widget-player-statistic-table-cell">
						<img src="http://widgets.baskethotel.com/static/images/flags/us.gif" alt="US" align="absmiddle" title="США">
					</td>
					<td class="stat-widget-player-statistic-table-cell">Защитник</td>
					<td class="stat-widget-player-statistic-table-cell">188 cm</td>
					<td class="stat-widget-player-statistic-table-cell">80 kg</td>
				</tr>
				<tr>
					<td class="stat-widget-player-statistic-table-cell">5</td>
					<td class="stat-widget-player-statistic-table-cell"><a href="protocol.html">Антонио Крокер</a></td>
					<td class="stat-widget-player-statistic-table-cell">17/01/1987</td>
					<td class="stat-widget-player-statistic-table-cell">
						<img src="http://widgets.baskethotel.com/static/images/flags/us.gif" alt="US" align="absmiddle" title="США">
					</td>
					<td class="stat-widget-player-statistic-table-cell">Форвард</td>
					<td class="stat-widget-player-statistic-table-cell">198 cm</td>
					<td class="stat-widget-player-statistic-table-cell">98 kg</td>
				</tr>
				<tr>
					<td class="stat-widget-player-statistic-table-cell">6</td>
					<td class="stat-widget-player-statistic-table-cell"><a href="protocol.html">Егор Вяльцев</a></td>
					<td class="stat-widget-player-statistic-table-cell">10/10/1985</td>
					<td class="stat-widget-player-statistic-table-cell">
						<img src="http://widgets.baskethotel.com/static/images/flags/ru.gif" alt="RU" align="absmiddle" title="Россия">
					</td>
					<td class="stat-widget-player-statistic-table-cell">Защитник</td>
					<td class="stat-widget-player-statistic-table-cell">193 cm</td>
					<td class="stat-widget-player-statistic-table-cell">86 kg</td>
				</tr>
			</table>
		</div>
	</div>
	
</div>
{% include 'tempfooter.tpl' %}