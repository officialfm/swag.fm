# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Player
  constructor: () ->
    $('.cover').on('click', @clickOnCover)

  clickOnCover: (event) ->
    $('#player').attr('src', $(event.target).attr('data-stream-url') + '?api_version=2')
    $('.cover').removeClass('playing')
    $(event.target).addClass('playing')
    $('#player')[0].play();

$(document).ready -> new Player
