class Player
  constructor: () ->
    @tracks().on('click', @clickOnCover.bind(this))

  clickOnCover: (event) ->
    if (event.target == @playingTrack())
      $(event.target).removeClass('playing')
      $(event.target).addClass('paused')
      @pause()
    else if (event.target == @pausedTrack())
      $(event.target).removeClass('paused')
      $(event.target).addClass('playing')
      $('#player')[0].play()
    else
      @play(event.target)

  tracks: () ->
    $('.track')

  play: (track) ->
    $('#player').attr('src', $(track).attr('data-stream-url') + '?api_version=2')
    @tracks().removeClass('playing')
    @tracks().removeClass('paused')
    $(track).addClass('playing')
    $('#player')[0].play()

  pause: () ->
    $('#player')[0].pause()

  playingTrack: () ->
    $('.track.playing')[0]

  pausedTrack: () ->
    $('.track.paused')[0]

$(document).ready -> new Player
