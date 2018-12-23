<!DOCTYPE html>
<html>
	<head>
		<title>Добавление протокола статистики</title>
		<meta charset="UTF-8">
		
	</head>
	<body>
		{% if isShowLoadButton %}
			<form action="statistics/loadprotocol" method="post" enctype="multipart/form-data">
				<label>
					Скачать образец протокола
					<input id="loadProtocol" type="submit" name="submit" value="Скачать" />
				</label>
			</form>
			</br>
			<form action="statistics/save" method="post" enctype="multipart/form-data">
				<input type="file" name="csv" value="" />
				<input type="submit" name="submit" value="Сохранить" />
			</form>
		{% else %}
			<input type="submit" name="cancel" value="Отмена" />
			<input type="submit" name="confirmed" value="Сохранить" />
		{% endif %}
	</body>
</html>
