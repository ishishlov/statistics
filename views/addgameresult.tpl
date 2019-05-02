<!DOCTYPE html>
<html>
	<head>
		<title>Добавление результата игры</title>
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
				</div>
			</div>

			<div class="add-result">
				<input type="date" value="{{ nowDate }}" />
				<select class="team1">
					{% for team in teams %}
						<option value="{{ team.team_id }}">{{ team.name }}</option>
					{% endfor %}
				</select>
				<input class="score1" type="text" maxlength="3" />
				:
				<input class="score2" type="text" maxlength="3" />
				<select class="team2">
					{% for team in teams %}
					<option value="{{ team.team_id }}">{{ team.name }}</option>
					{% endfor %}
				</select>
				<input class="add-game-result-button" type="button" value="Добавить" />
			</div>

		</div>
		<script type="text/javascript" src="/js/jquery3.3.1.js"></script>
		<script type="text/javascript" src="/js/addgameresult.js"></script>
	</body>
</html>
