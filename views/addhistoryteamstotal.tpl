<!DOCTYPE html>
<html>
	<head>
		<title>Добавление командной статистики</title>
		<meta charset="UTF-8">
		<meta name="robots" content="noindex, nofollow"/>
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
					<form class="header-button" action="/admin/loadHistoryTeamsTotalPrototype" method="post" enctype="multipart/form-data">
						<input id="loadProtocol" type="submit" name="submit" value="Образец протокола" />
					</form>
					<form class="header-button" action="/admin/addGameResult" method="post">
						<input type="submit" name="submit" value="Добавить результат игры" />
					</form>
				</div>
			</div>
			{% if isShowLoadButton %}
				<form class="save-protocol" action="/admin/addHistoryTeamsTotal" method="post" enctype="multipart/form-data">
					<input class="btn-center" type="file" name="csv" value="" />
					<input class="btn-save" type="submit" name="saveProtocol" value="Сохранить" />
				</form>
			{% else %}
				<form action="/admin/addHistoryTeamsTotal" method="post">
					<input class="btn-save" type="submit" name="cancel" value="Отмена" />
					<input class="btn-save" type="submit" name="confirmed" value="Сохранить" />
				</form>
					<div class="confirm-save">
						<table class="stat-widget-season-statistic-table">
							<colgroup>
								<col width="70" />
								<col width="60" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
								<col width="50" />
							</colgroup>
							<tbody>
								<tr class="stat-widget-table-head-row">
									<th class="stat-widget-season-statistic-table-cell-head stat-widget-table-first-column"></th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2-ОЧК</th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="3">3-ОЧК</th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="3">2+3-ОЧК</th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ШТР</th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="3">ПД</th>
									<th class="stat-widget-season-statistic-table-cell-head"></th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="2">Ф</th>
									<th class="stat-widget-season-statistic-table-cell-head"></th>
									<th class="stat-widget-season-statistic-table-cell-head"></th>
									<th class="stat-widget-season-statistic-table-cell-head" colspan="2"></th>
									<th class="stat-widget-season-statistic-table-cell-head"></th>
									<th class="stat-widget-season-statistic-table-cell-head"></th>
									<th class="stat-widget-season-statistic-table-cell-head-end"></th>
								</tr>
								<tr class="stat-widget-table-head-row">
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end stat-widget-table-first-column">Команда</td>
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
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">РП</td>
									<td class="stat-widget-season-statistic-table-cell-bold">Ф</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">ФС</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пт</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Пх</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">БШ НА</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">Эфф</td>
									<td class="stat-widget-season-statistic-table-cell-bold stat-widget-season-statistic-table-cell-end">+/-</td>
									<td class="stat-widget-season-statistic-table-cell-bold">Оч</td>
									</tr>
								{% for data in notConfirmedData %}
									<tr>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-first-column stat-widget-game-statistic-table-name">
											<div class="stat-widget-table-adaptive-name">{{ data.name }}</div>
										</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.two_point_made }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.two_point_throw }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.two_point_percent }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.three_point_made }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.three_point_throw }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.three_point_percent }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.two_three_point_made }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.two_three_point_throw }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.two_three_point_percent }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.free_made }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.free_throw }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.free_percent }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.offensive_rebound }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.deffensive_rebound }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.sum_rebound }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.assists }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.commited_foul }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.recieved_foul }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.turnover }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.steal }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.in_fawor }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.against }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.effectiveness }}</td>
										<td class="stat-widget-season-statistic-table-cell-end stat-widget-table-not-first-column">{{ data.plus_minus }}</td>
										<td class="stat-widget-season-statistic-table-cell stat-widget-table-not-first-column">{{ data.points_scored }}</td>
									</tr>
								{% endfor %}	
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
