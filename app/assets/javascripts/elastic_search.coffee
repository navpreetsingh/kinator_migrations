# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.ui.dropdown').dropdown()

  $(".search").keyup ->
    ip = $(this).val()
    $.ajax
    	type: "POST"
    	url: "/elastic_suggestion"
    	data: {ip: ip}
    false


