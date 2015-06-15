// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function () {
	var count = 0;
	$('.question-field').each(function () {
		//console.log('count = '+count);
		$(this).find('.order').val(count).html();	
		count++;		
	});
	count = 0;
})

$(function(){
	$('.create-button-add').click(function() {
		$(function templateMaker() {
			var templateString = $('#question-template').html();
		
			var uniqueNum = 0;
		
			$('.question-field').last().each(function () {
				$(this).find('input').each(function () {
					if (uniqueNum<parseInt($(this).attr('name').match(/\d+/)))
					uniqueNum = parseInt($(this).attr('name').match(/\d+/));
				});
			});
			
			uniqueNum = uniqueNum+1;
			// Compile the template as per usual:
			var compiledTemplate = _.template(templateString.replace(/\[[0-9]+\]/g, uniqueNum), { variable: 'm' });
			
			//console.log('ONE'+compiledTemplate());
			$('.questions-container').append(compiledTemplate());
			
			$(function () {
				$('.questions-container').sortable();
			})
			
			$(function () {
				var count = 0;
				$('.question-field').each(function () {
					//console.log('count = '+count);
					$(this).find('.order').val(count).html();	
					count++;		
				});
				count = 0;
			})
			
			//console.log('TWO'+compiledTemplate());
				
			$('.create-button-remove').click(function() {
				$(this).parent().find('input:checkbox').prop('checked', true);
				$(this).parent().css('display','none');
			});
			$('.questions-container').mouseup(function () {
				setTimeout(function () {var count = 0;
				$('.question-field').each(function () {
					console.log('count = '+count);
					$(this).find('.order').val(count).html();	
					count++;		
				});
				count = 0;
				
				});		
			});

		$('.create-button-remove').click(function() {
			$(this).parent().remove();
		});
	});
});
});

$(function(){
	$('.create-button-remove').click(function() {
		$(this).parent().find('.delete').prop('checked', true);
		$(this).parent().css('display','none');
	});
});

$(function () {
	$('.questions-container').sortable();
})

$(function () {
	$('.questions-container').mouseup(function () {
		setTimeout(function () {var count = 0;
			$('.question-field').each(function () {
				console.log('count = '+count);
				$(this).find('.order').val(count).html();	
				count++;		
			});
			count = 0;
		});		
	});
});

$(function(){
	if ($('#notice').text()!== '') {
		$('.header').append('<div class="notice"><h1>'+$('#notice').text()+'</h1></div>');
		setTimeout(function () {
			$('.notice').remove();	
		},1500);
	}
});
