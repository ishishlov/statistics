{% include 'tempheader.tpl' %}
<link rel="stylesheet" href="/css/style.css" />
<div class="stat-widget-container﻿">
	<div class="stat-widget-wrap-main">
		<div class="stat-widget-title-main">Командная статистика</div>
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
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.min_turnover }}</td> <!--  -->
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_steal }}</td>
						<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_in_fawor }}</td>
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_against }}</td>
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_effectiveness }}</td>
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.max_points_scored }}</td>
						<td class="stat-widget-season-statistic-table-cell-end">{{ seasonsStatistic.min_op }}</td> <!--  -->
						<td class="stat-widget-season-statistic-table-cell">{{ seasonsStatistic.max_plus_minus }}</td> <!--  -->
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
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">15/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/c7/c7374addfc143be4e859650e67929cff1450270957.jpg) left center no-repeat;">Фенербахче</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">76:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">14/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/89/89892411e214a4304fb975e03cc84ed11450991467.jpg) left center no-repeat;">Реал Мадрид</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">86:69</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">13/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/d9/d9f621e9bed1350556fbc7fcb1d82aea1505849888.jpg) left center no-repeat;">ЦСКА</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">55:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">12/10/2017</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/6b/6b4b5994717e7afcc171bff4cbf95d0b1538854820.jpg) left center no-repeat;">Анадолу Эфес</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">78:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">15/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/c7/c7374addfc143be4e859650e67929cff1450270957.jpg) left center no-repeat;">Фенербахче</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">76:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">14/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/89/89892411e214a4304fb975e03cc84ed11450991467.jpg) left center no-repeat;">Реал Мадрид</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">86:69</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">13/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/d9/d9f621e9bed1350556fbc7fcb1d82aea1505849888.jpg) left center no-repeat;">ЦСКА</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">55:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">12/10/2017</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/6b/6b4b5994717e7afcc171bff4cbf95d0b1538854820.jpg) left center no-repeat;">Анадолу Эфес</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">78:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">15/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/c7/c7374addfc143be4e859650e67929cff1450270957.jpg) left center no-repeat;">Фенербахче</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">76:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">14/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/89/89892411e214a4304fb975e03cc84ed11450991467.jpg) left center no-repeat;">Реал Мадрид</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">86:69</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">13/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/d9/d9f621e9bed1350556fbc7fcb1d82aea1505849888.jpg) left center no-repeat;">ЦСКА</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">55:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">12/10/2017</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/6b/6b4b5994717e7afcc171bff4cbf95d0b1538854820.jpg) left center no-repeat;">Анадолу Эфес</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">78:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">15/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/c7/c7374addfc143be4e859650e67929cff1450270957.jpg) left center no-repeat;">Фенербахче</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">76:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">14/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/89/89892411e214a4304fb975e03cc84ed11450991467.jpg) left center no-repeat;">Реал Мадрид</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">дома</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">86:69</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">13/10/2018</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/d9/d9f621e9bed1350556fbc7fcb1d82aea1505849888.jpg) left center no-repeat;">ЦСКА</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">55:68</a></td>
				</tr>
				<tr>
					<td class="stat-widget-game-statistic-table-cell-left">12/10/2017</td>
					<td class="stat-widget-game-statistic-table-cell-center">Евролига</td>
					<td class="stat-widget-game-statistic-table-cell-left"><a class="stat-widget-game-statistic-team-logo" target="_blank" href="teamgames.html" style="background:url(https://bckhimki.ru/thumbs/6b/6b4b5994717e7afcc171bff4cbf95d0b1538854820.jpg) left center no-repeat;">Анадолу Эфес</a></td>
					<td class="stat-widget-game-statistic-table-cell-center">в&nbsp;гостях</td>
					<td class="stat-widget-game-statistic-table-cell-center"><a href="protocol.html">78:68</a></td>
				</tr>
			</table>
			<div class="stat-widget-info">Euroleague — европейский баскетбольный турнир среди профессиональных мужских клубов из стран, являющихся членами ФИБА Европа.
				<br /><br />
				* В соответствии с Регламентом Евролиги 2018/2019 гг., все очки, набранные в овертайме(ах), не будут учитываться в турнирной таблице, а также для любой ситуации тай-брейков.<div class="stat-widget-info-link"><a target="_blank" href="http://www.euroleague.net/main/standings">http://www.euroleague.net/main/standings</a></div>
			</div>
		</div>
	</div>
	
</div>
{% include 'tempfooter.tpl' %}