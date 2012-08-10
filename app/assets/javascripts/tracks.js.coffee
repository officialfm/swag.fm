class Player
  constructor: () ->
    @tracks().on('click', @clickOnCover.bind(this))
    $('.tracks [data-action=delete]').on('click', @clickOnDelete.bind(this))

    $(@audio()).on('ended', @playNextTrack.bind(this))
    $('.tracks').on('DOMNodeInserted', @trackAdded.bind(this))

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

  clickOnDelete: (event) ->
    track = $(event.target).closest('[data-url]')
    $.ajax(track.attr('data-url'), type: 'DELETE', success: => track.remove())

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

  trackAdded: (event) ->
    $(event.target).on('click', @clickOnCover.bind(this))
    $(event.target).find('[data-action=delete]').on('click', @clickOnDelete.bind(this))

$(document).ready -> new Player
