class Player
  constructor: () ->
    @tracks().on('click', @clickOnCover.bind(this))

  clickOnCover: (event) ->
    $('#player').attr('src', $(event.target).attr('data-stream-url') + '?api_version=2')
    @tracks().removeClass('playing')
    $(event.target).addClass('playing')
    $('#player')[0].play()

  tracks: () ->
    $('.cover')

$(document).ready -> new Player
