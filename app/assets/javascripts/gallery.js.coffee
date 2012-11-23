class @Gallery
  constructor: (@player) ->
    @resizeTracksHeight()
    @player.observe('play', @play.bind(this))
    @player.observe('pause', @pause.bind(this))
    @initializeEvents()

  initializeEvents: () ->
    @play(@player.playingTrack) if @player.playingTrack
    $('.tracks').on('DOMNodeInserted', @trackAdded.bind(this))
    $('.tracks').on('dragover', @dragOverTrack.bind(this))
    $('.tracks').on('drop', @dropTrack.bind(this))
    $(window).resize(@resizeTracksHeight.bind(this))
    @listenTrackEvents($('.tracks'))
    @resizeTracksHeight()

  resizeTracksHeight: () ->
    setTimeout( -> $('.track').height($('.track').width()))

  listenTrackEvents: (collection) ->
    collection.find('[data-action=play]').on('click', @clickOnPlay.bind(this))
    collection.find('[data-action=pause]').on('click', @clickOnPause.bind(this))
    collection.find('[data-action=delete]').on('click', @clickOnDelete.bind(this))
    collection.find('[data-action=import]').on('click', @clickOnImport.bind(this))
    collection.find('[data-action=move]').on('dragstart', @dragTrack.bind(this))

  trackAdded: (event) ->
    @listenTrackEvents($(event.target))

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

  clickOnPlay: (event) ->
    anchor = event.target.attributes.getNamedItem('data-target').value
    unless track = @player.findTrackByAnchor(anchor)
      @player.reloadTracks()
      track = @player.findTrackByAnchor(anchor)
    @player.play(track)

  clickOnPause: (event) ->
    @player.pause()

  clickOnDelete: (event) ->
    track = $(event.target).closest('[data-url]')
    $.ajax(track.attr('data-url'), type: 'DELETE', success: => track.remove())

  clickOnImport: (event) ->
    target = $('#' + $(event.target).attr('data-target'))
    $.ajax('/favorites', type: 'POST', data: {url: target.attr('data-origin-url')}, success: -> alert('Track added.'))

  play: (track) ->
    $('.track').removeClass('playing')
    $('.track').removeClass('paused')
    $('#' + track.anchor).addClass('playing')

  pause: (track) ->
    $('#track_' + track.id).addClass('paused')
    $('#track_' + track.id).removeClass('playing')
