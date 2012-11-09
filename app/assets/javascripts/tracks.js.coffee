class Player
  constructor: () ->
    $(@audio()).on('ended', @playNextTrack.bind(this))
    @initializeEvents()
    @autoPlay()

  initializeEvents: () ->
    $("html").keydown(@keyPressed.bind(this))

    $('.tracks').on('DOMNodeInserted', @trackAdded.bind(this))
    $('.tracks').on('dragover', @dragOverTrack.bind(this))
    $('.tracks').on('drop', @dropTrack.bind(this))
    @listenTrackEvents($('.tracks'))

    @playButton().on('click', @clickOnPlayButton.bind(this))
    @nextButton().on('click', @clickOnNextButton.bind(this))
    @previousButton().on('click', @clickOnPreviousButton.bind(this))

  autoPlay: () ->
    if window.location.hash && $(window.location.hash)[0]
      @play($(window.location.hash)[0])

  dragTrack: (event) ->
    event.originalEvent.dataTransfer.setData("Text", $(event.target).attr('data-target'))

  dragOverTrack: (event) ->
    event.preventDefault()

  dropTrack: (event) ->
    event.preventDefault()
    event = event.originalEvent
    target = $(event.target).closest('[data-url]')[0]
    draggedTrack = $('#' + event.dataTransfer.getData("Text"))[0]
    if (parseInt($(draggedTrack).attr('data-position')) < parseInt($(target).attr('data-position')))
      target.parentNode.insertBefore(draggedTrack, target.nextSibling)
    else
      target.parentNode.insertBefore(draggedTrack, target)
    @tracks().each (index, track) -> $(track).attr('data-position', index + 1)
    $.ajax($(draggedTrack).attr('data-url'), type: 'PUT', data: {position: $(draggedTrack).attr('data-position')})

  keyPressed: (event) ->
    if (event.which == 32) # 32 is space key code.
      event.preventDefault()
      @togglePlayback()

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

  clickOnImport: (event) ->
    target = $('#' + $(event.target).attr('data-target'))
    $.ajax('/favorites', type: 'POST', data: {url: target.attr('data-origin-url')}, success: -> alert('Track added.'))

  tracks: () ->
    $('.track')

  play: (track) ->
    if (track)
      $(@audio()).attr('src', $(track).attr('data-stream-url') + '?client_id=880faec8a616cb8ddc4fc35fe410b644')
      @tracks().removeClass('playing')
      @tracks().removeClass('paused')
      $(track).addClass('playing')
    @audio().play()
    @playButton().addClass('pause')
    @playButton().removeClass('play')
    $(@pausedTrack()).addClass('playing')
    $(@pausedTrack()).removeClass('paused')
    if track
      $('#current-track').text($(@playingTrack()).attr('title'))
      $('#current-track')[0].href = '#' + track.id

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
    @play(@nextTrack() || $('.track')[0])

  playPreviousTrack: () ->
    @play(@previousTrack()) if @previousTrack()

  audio: () ->
    @audioElement || (@audioElement = document.createElement('audio'))

  trackAdded: (event) ->
    @listenTrackEvents($(event.target))

  listenTrackEvents: (collection) ->
    collection.find('[data-action=play]').on('click', @clickOnPlay.bind(this))
    collection.find('[data-action=pause]').on('click', @clickOnPause.bind(this))
    collection.find('[data-action=delete]').on('click', @clickOnDelete.bind(this))
    collection.find('[data-action=import]').on('click', @clickOnImport.bind(this))
    collection.find('[data-action=move]').on('dragstart', @dragTrack.bind(this))

  playButton: () ->
    $('#play-button')

  nextButton: () ->
    $('#next-button')

  previousButton: () ->
    $('#previous-button')

  clickOnPlayButton: () ->
    @togglePlayback()

  togglePlayback: () ->
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

  pageChanged: () ->
    @initializeEvents()

$(document).ready ->
  player = new Player
  $(window).bind('page:change', player.pageChanged.bind(player))
