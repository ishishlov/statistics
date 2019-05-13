<!DOCTYPE html>
<html>
	<head>
		<title>Добавление протокола статистики</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="/css/index.css" />
	</head>
	<body>
		<div class="container-main">
			<div class="header">
				<div class="header-1">
					<div class="header-title">СТАТИСТИКА</div>
				</div>
				<div class="header-2">
					<a href="https://bckhimki.ru/" class="logo">
						<img src="https://bckhimki.ru/i/v7/icons/bckhimki_logo.png" alt="Баскетбольный клуб Химки">
					</a>
					<form class="header-button" action="statistics/loadprotocol" method="post" enctype="multipart/form-data">
						<input id="loadProtocol" type="submit" name="submit" value="Образец протокола" />
					</form>
					<form class="header-button" action="statistics/addGameResult" method="post">
						<input type="submit" name="submit" value="Добавить результат игры" />
					</form>
				</div>
			</div>
			{% if isShowLoadButton %}
				<form class="save-protocol" action="/" method="post" enctype="multipart/form-data">
					<input class="btn-center" type="file" name="csv" value="" />
					<input class="btn-save" type="submit" name="saveProtocol" value="Сохранить" />
				</form>
			{% else %}
				<form action="/" method="post">
					<input class="btn-save" type="submit" name="cancel" value="Отмена" />
					<input class="btn-save" type="submit" name="confirmed" value="Сохранить" />
				</form>
				<div class="confirm-save">
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
								<td class="stat-widget-season-statistic-table-cell stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_turnover }}</td>
								<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
								<td class="stat-widget-season-statistic-table-cell-bold">иг</td>
								<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">на</td>
								<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
								<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">&nbsp;</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.min_plus_minus }}</td>
							</tr>
							<tr>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_two_point_made }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_two_point_throw }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_two_point_percent }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_three_point_made }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_three_point_throw }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_three_point_percent }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_two_three_point_made }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_two_three_point_throw }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_two_three_point_percent }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_free_made }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_free_throw }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_free_percent }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_offensive_rebound }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_deffensive_rebound }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_sum_rebound }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_assists }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_commited_foul }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_recieved_foul }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.min_turnover }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_steal }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_in_fawor }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_against }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_effectiveness }}</td>
								<td class="stat-widget-season-statistic-table-cell-end">{{ notConfirmedData.max_points_scored }}</td>
								<td class="stat-widget-season-statistic-table-cell">{{ notConfirmedData.max_plus_minus }}</td>
							</tr>
						</tbody>
					</table>
				</div>
			{% endif %}
			{% if errors %}
				<div class="errors">
					{% for error in errors %}
						<div class="error">
							<div class="error-text">{{ error.text }}</div>
							<div class="error-value">{{ error.value }}</div>
						</div>
					{% endfor %}
				</div>
			{% endif %}
		</div>
	</body>
</html>
