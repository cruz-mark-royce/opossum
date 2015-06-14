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

$(function(){
$('.create-button-add').click(function() {
	$(function templateMaker() {
	var templateString = $('#question-template').html();

	// Compile the template as per usual:
	var compiledTemplate = _.template(templateString, { variable: 'm' });
	
// Render the template out to our main div tag:
	$('.questions-container').append(compiledTemplate());
	
	$('.create-button-add').click(function() {
	$(function templateMaker() {
	var templateString = $('#question-template').html();

	// Compile the template as per usual:
	var compiledTemplate = _.template(templateString, { variable: 'm' });

	console.log(compiledTemplate());
// Render the template out to our main div tag:
	$('.questions-container').append(compiledTemplate());
	$(function(){
$('.create-button-remove').click(function() {
	$(this).parent().remove();
});
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