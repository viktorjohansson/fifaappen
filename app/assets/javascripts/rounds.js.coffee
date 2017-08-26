# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  $('#home_team').hover (->
    $('#home_players').show()
    return
  ), ->
    $('#home_players').hide()
    return
	
$(document).on 'ready page:load', ->
  $('#away_team').hover (->
    $('#away_players').show()
    return
  ), ->
    $('#away_players').hide()
    return
	
	  
	  
recognition = new webkitSpeechRecognition
recognition.continuous = false
recognition.interimResults = false
recognition.lang = "sv-SE"

recognition.onend = (event) ->
	$('.speechinput').css('backgroundImage', "url('../assets/mic.gif')")
	return
	
recognition.onresult = (event) ->
  interim_transcript = ''
  final_transcript = ''
  i = event.resultIndex
  while i < event.results.length
    if event.results[i].isFinal
      final_transcript += event.results[i][0].transcript
    else
      interim_transcript += event.results[i][0].transcript
    ++i
  $("#matches").find(':visible').find("#match_home").val(final_transcript[0])
  $("#matches").find(':visible').find("#match_away").val(final_transcript[final_transcript.length - 1])
  $('.speechinput').css('backgroundImage', "url('../assets/mic.gif')")
  return

$('.speechinput').on 'click', ->
  recognition.stop()
  recognition.start()
  $('.speechinput').css('backgroundImage', "url('../assets/mic-animate.gif')")
  return
