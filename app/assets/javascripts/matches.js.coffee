# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
	$(".match").first().show()
	randomint = Math.random()
	dm = false
	if randomint > 0.8
	    dm = true
	
$(document).ready ->
  $(".new_match").on("ajax:success", (e, data, status, xhr) ->
	  value = random
	  $("#matches").find(':visible').hide().next().show()
	  #$("#matches").find(':visible').find("#match_bet").prop("checked", value)
	  home_team = $("#matches").find(':visible').find("#home_team")
	  away_team = $("#matches").find(':visible').find("#away_team")
	  home_players = $("#matches").find(':visible').find("#home_players")
	  away_players = $("#matches").find(':visible').find("#away_players")
	  #sound()
	  home_team.hover (->
	    home_players.show()
	    return
	  ), ->
	    home_players.hide()
	    return
	  away_team.hover (->
	    away_players.show()
	    return
	  ), ->
	    away_players.hide()
	    return
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_match").append "<p>ERROR</p>"
	
random = ->
	randomint = Math.random()
	dm = false
	if randomint > 0.8
	    dm = true
		return dm

sound = ->
	if $("#matches").find(':visible').find("#match_bet").prop("checked")
		audio = new Audio('assets/audio.mp3')
		audio.volume = 1.0
		audio.play()