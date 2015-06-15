$(function(){
$('.create-button-add').click(function() {
	$(function templateMaker() {
	var templateString = $('#question-template').html();

	// Compile the template as per usual:
	var compiledTemplate = _.template(templateString, { variable: 'm' });
	
	console.log(compiledTemplate());
// Render the template out to our main div tag:
	$('.questions-container').append(compiledTemplate());
	
		$('.create-button-remove').click(function() {
			$(this).parent().remove();
		});
		
		$('.create-button-add').click(function() {
		$(function templateMaker() {
		var templateString = $('#question-template').html();
	
		// Compile the template as per usual:
		var compiledTemplate = _.template(templateString, { variable: 'm' });
		
		console.log(compiledTemplate());
	// Render the template out to our main div tag:
		$('.questions-container').append(compiledTemplate());
		
		$('.create-button-remove').click(function() {
			$(this).parent().remove();
		});
	
});
});
	
});
});
});

$(function(){
$('.create-button-remove').click(function() {
	$(this).parent().remove();
});
});