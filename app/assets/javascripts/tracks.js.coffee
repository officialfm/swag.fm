class Gallery
  constructor: (@player) ->
    @player.observe('play', @play.bind(this))
    @player.observe('pause', @pause.bind(this))
    @initializeEvents()

  initializeEvents: () ->
    $('.tracks').on('DOMNodeInserted', @trackAdded.bind(this))
    $('.tracks').on('dragover', @dragOverTrack.bind(this))
    $('.tracks').on('drop', @dropTrack.bind(this))
    @listenTrackEvents($('.tracks'))

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
    trackId = parseInt(event.target.attributes.getNamedItem('data-target').value.replace('track_', ''))
    @player.play(@player.findTrackById(trackId))

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
    $('#track_' + track.id).addClass('playing')

  pause: (track) ->
    $('#track_' + track.id).addClass('paused')
    $('#track_' + track.id).removeClass('playing')


class Controller
  constructor: (@player) ->
    @player.observe('play', @play.bind(this))
    @player.observe('pause', @play.bind(this))
    @initializeEvents()

  initializeEvents: () ->
    $("html").keydown(@keyPressed.bind(this))
    @playButton().on('click', @clickOnPlayButton.bind(this))
    @nextButton().on('click', @clickOnNextButton.bind(this))
    @previousButton().on('click', @clickOnPreviousButton.bind(this))
    $('#add-button').on('click', @clickOnAddButton.bind(this))

  play: (track) ->
    $('#current-track').text(track.title + ' - ' + track.title)
    $('#current-track')[0].href = '#' + track.id
    @playButton().removeClass('play')
    @playButton().addClass('pause')

  pause: (track) ->
    @playButton().addClass('play')
    @playButton().removeClass('pause')

  keyPressed: (event) ->
    if (event.which == 32) # Space
      event.preventDefault()
      @player.togglePlayback()
    else if (event.which == 37) # Left
      event.preventDefault()
      @player.playPreviousTrack()
    else if (event.which == 39) # Right
      event.preventDefault()
      @player.playNextTrack()

  playButton: () ->
    $('#play-button')

  nextButton: () ->
    $('#next-button')

  previousButton: () ->
    $('#previous-button')

  clickOnPlayButton: () ->
    @togglePlayback()

  clickOnNextButton: () ->
    @playNextTrack()

  clickOnPreviousButton: () ->
    @playPreviousTrack()

  clickOnAddButton: ->
    url = prompt("Copy a track URL from official.fm or soundcloud.com.")
    if url.match(/official\.fm/) || url.match(/soundcloud\.com/)
      @addTrack(url)
    else
      alert("This is neither a URL from official.fm not soundcloud.com.")

  addTrack: (url) ->
    $.ajax('/favorites', type: 'POST', data: {url: url}, success: (response) =>
      $('.tracks')[0].insertBefore($(response)[0], @tracks()[0])
      $('.blank.slate').remove()
    )

  playNextTrack: () ->
    @player.playNextTrack()#(@player.nextTrack() || @player.tracks[0])

  playPreviousTrack: () ->
    @player.playPreviousTrack()


class Track
  constructor: (attributes) ->
    @id = attributes['id']
    @url = attributes['url']
    @title = attributes['title']
    @artist = attributes['artist']
    @position= attributes['position']
    @streamUrl = attributes['streamUrl']
    @originUrl= attributes['originUrl']
    @coverUrl = attributes['coverUrl']

  observe: (name, callback) ->
    @callbacks || (@callbacks = {})
    @callbacks[name] || (@callbacks[name] = [])
    this.callbacks[name].push(callback)

  notify: (name) ->
    if @callbacks && @callbacks[name]
      for callback in @callbacks[name]
        callback.apply(undefined, Array.prototype.slice.call(arguments, 1))

class Player
  constructor: () ->
    $(@audio()).on('ended', @playNextTrack.bind(this))
    @autoPlay()

  observe: (name, callback) ->
    @callbacks || (@callbacks = {})
    @callbacks[name] || (@callbacks[name] = [])
    this.callbacks[name].push(callback)

  notify: (name) ->
    if @callbacks && @callbacks[name]
      for callback in @callbacks[name]
        callback.apply(undefined, Array.prototype.slice.call(arguments, 1))

  autoPlay: () ->
    if window.location.hash && $(window.location.hash)[0]
      @play($(window.location.hash)[0])

  findTrackById: (id) ->
    for track in @tracks()
      if track.id == id
        return track

  tracks: () ->
    @_tracks || (@_tracks = @loadTracks())

  loadTracks: () ->
    array = []
    for element in $('.track')
      element = $(element)
      array.push(new Track({
        id: parseInt(element.attr('id').replace('track_', ''))
        artist: element.attr('data-artist')
        title: element.attr('data-title')
        url: element.attr('data-url')
        streamUrl: element.attr('data-stream-url')
        originUrl: element.attr('data-origin-url')
      }))
    array

  play: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      $(@audio()).attr('src', track.streamUrl + '?api_key=4qpH1KdXhJF64NPD3zdK7t2gpTF8vHHz&client_id=880faec8a616cb8ddc4fc35fe410b644')
    @notify('play', @playingTrack = track)
    @pausedTrack = null
    @audio().play()

  pause: () ->
    @pausedTrack = @playingTrack
    @playingTrack = null
    @audio().pause()
    @notify('pause', @pausedTrack)

  nextTrack: () ->
    if (@playingTrack)
      @tracks()[@tracks().indexOf(@playingTrack) + 1]
    else
      @tracks()[0]

  previousTrack: () ->
    if (@playingTrack)
      @tracks()[@tracks().indexOf(@playingTrack) - 1]

  pausedTrack: () ->
    $('.track.paused')[0]

  playNextTrack: () ->
    @play(@nextTrack() || $('.track')[0])

  playPreviousTrack: () ->
    @play(@previousTrack()) if @previousTrack()

  audio: () ->
    @audioElement || (@audioElement = document.createElement('audio'))

  togglePlayback: () ->
    if @playingTrack
      @pause()
    else if @pausedTrack
      @play(@pausedTrack)
    else
      @play(@tracks()[0])

class SwagFm
  constructor: () ->
    @player = new Player()
    @gallery = new Gallery(@player)
    @controller = new Controller(@player)

  pageChanged: () ->
    @gallery.initializeEvents()
    @controller.initializeEvents()

$(document).ready ->
  swagFm = new SwagFm
  $(window).bind('page:change', swagFm.pageChanged.bind(swagFm))
