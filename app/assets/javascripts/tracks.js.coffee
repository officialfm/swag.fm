class Player
  constructor: () ->
    @tracks().on('click', @clickOnCover.bind(this))
    $(@audio()).on('ended', @playNextTrack.bind(this))

  clickOnCover: (event) ->
    if (event.target == @playingTrack())
      $(event.target).removeClass('playing')
      $(event.target).addClass('paused')
      @pause()
    else if (event.target == @pausedTrack())
      $(event.target).removeClass('paused')
      $(event.target).addClass('playing')
      @audio().play()
    else
      @play(event.target)

  tracks: () ->
    $('.track')

  play: (track) ->
    $(@audio()).attr('src', $(track).attr('data-stream-url') + '?api_version=2')
    @tracks().removeClass('playing')
    @tracks().removeClass('paused')
    $(track).addClass('playing')
    @audio().play()

  pause: () ->
    @audio().pause()

  playingTrack: () ->
    $('.track.playing')[0]

  nextTrack: () ->
    $('.track.playing').next()

  pausedTrack: () ->
    $('.track.paused')[0]

  playNextTrack: () ->
    @play(@nextTrack()) if @nextTrack()

  audio: () ->
    $('#audio')[0]

$(document).ready -> new Player
