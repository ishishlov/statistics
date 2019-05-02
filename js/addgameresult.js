(function($) {
	$(function() {
		addGameResult.init();
	});
	var addGameResult = (function() {
		var _module;
		var $_mainContainer;

		return {
			init: function() {
				_module = this;
				$_mainContainer = $('.add-result');

				//Добавление игры
				$_mainContainer.on('click', '.add-game-result-button', function (event) {
					_module.addGameResult();
				});
			},

			addGameResult: function () {
				_module.showLoader();
				var url = '/statistics/ajaxAddGameResult';
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json'
				}).done(function(response) {
					_module.hideLoader();
					if (response.result) {
						alert('Сохранено');
					} else {
						alert(response.error);
					}
				});
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
