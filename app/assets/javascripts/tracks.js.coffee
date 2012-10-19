class Player
  constructor: () ->
    $('[data-action=play]').on('click', @clickOnPlay.bind(this))
    $('[data-action=pause]').on('click', @clickOnPause.bind(this))
    $('[data-action=delete]').on('click', @clickOnDelete.bind(this))

    $(@audio()).on('ended', @playNextTrack.bind(this))


    $('.tracks').on('DOMNodeInserted', @trackAdded.bind(this))
    $('[data-action=move]').on('dragstart', @dragTrack.bind(this))
    $('.tracks').on('dragover', @dragOverTrack.bind(this))
    $('.tracks').on('drop', @dropTrack.bind(this))

    @playButton().on('click', @clickOnPlayButton.bind(this))
    @nextButton().on('click', @clickOnNextButton.bind(this))
    @previousButton().on('click', @clickOnPreviousButton.bind(this))

  dragTrack: (event) ->
    console.log('drag')
    console.log($(event.target).attr('data-target'))
    event.originalEvent.dataTransfer.setData("Text", $(event.target).attr('data-target'))

  dragOverTrack: (event) ->
    event.preventDefault()

  dropTrack: (event) ->
    event.preventDefault()
    event = event.originalEvent
    target = $(event.target).closest('[data-url]')[0]
    draggedTrack = $('#' + event.dataTransfer.getData("Text"))[0]
    if ($(draggedTrack).attr('data-position') < $(target).attr('data-position'))
      target.parentNode.insertBefore(draggedTrack, target.nextSibling)
    else
      target.parentNode.insertBefore(draggedTrack, target)
    @tracks().each (index, track) ->
      $(track).attr('data-position', index + 1)
      $.ajax($(track).attr('data-url'), type: 'PUT', data: {position: $(track).attr('data-position')})

  clickOnPlay: (event) ->
    clickedTrack = $('#' + $(event.target).attr('data-target'))[0]
    if (clickedTrack == @pausedTrack())
      @play()
    else
      @play(clickedTrack)

  clickOnPause: (event) ->
    @pause()

  clickOnDelete: (event) ->
    track = $(event.target).closest('[data-url]')
    $.ajax(track.attr('data-url'), type: 'DELETE', success: => track.remove())

  tracks: () ->
    $('.track')

  play: (track) ->
    if (track)
      $(@audio()).attr('src', $(track).attr('data-stream-url') + '?api_version=2')
      @tracks().removeClass('playing')
      @tracks().removeClass('paused')
      $(track).addClass('playing')
    @audio().play()
    @playButton().addClass('pause')
    @playButton().removeClass('play')
    $(@pausedTrack()).addClass('playing')
    $(@pausedTrack()).removeClass('paused')

  pause: () ->
    @audio().pause()
    @playButton().addClass('play')
    @playButton().removeClass('pause')
    $(@playingTrack()).addClass('paused')
    $(@playingTrack()).removeClass('playing')

  playingTrack: () ->
    $('.track.playing')[0]

  nextTrack: () ->
    $('.track.playing').next()[0] || $('.track.paused').next()[0]

  previousTrack: () ->
    $('.track.playing').prev()

  pausedTrack: () ->
    $('.track.paused')[0]

  playNextTrack: () ->
    @play(@nextTrack()) if @nextTrack()

  playPreviousTrack: () ->
    @play(@previousTrack()) if @previousTrack()

  audio: () ->
    $('#audio')[0]

  trackAdded: (event) ->
    $(event.target).find('[data-action=play]').on('click', @clickOnPlay.bind(this))
    $(event.target).find('[data-action=pause]').on('click', @clickOnPause.bind(this))
    $(event.target).find('[data-action=delete]').on('click', @clickOnDelete.bind(this))

  playButton: () ->
    $('#play-button')

  nextButton: () ->
    $('#next-button')

  previousButton: () ->
    $('#previous-button')

  clickOnPlayButton: () ->
    if (@playingTrack())
      @pause()
    else if (@pausedTrack())
      @play()
    else
      @play(@tracks()[0])

  clickOnNextButton: () ->
    @playNextTrack()

  clickOnPreviousButton: () ->
    @playPreviousTrack()

$(document).ready -> new Player
