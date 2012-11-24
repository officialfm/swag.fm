class @Player
  constructor: () ->
    @official = document.createElement('audio')
    @soundcloud = document.createElement('audio')
    $(@official).on('ended', @playNextTrack.bind(this))
    $(@soundcloud).on('ended', @playNextTrack.bind(this))
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

  findTrackByAnchor: (anchor) ->
    for track in @tracks()
      if track.anchor == anchor
        return track

  findTrackById: (id) ->
    for track in @tracks()
      if track.id == id
        return track

  tracks: () ->
    @_tracks || @reloadTracks()

  reloadTracks: () ->
    @_tracks = @loadTracks()

  loadTracks: () ->
    array = []
    for element in $('.track')
      element = $(element)
      array.push(new Track({
        anchor: element.attr('id')
        id: parseInt(element.attr('data-track-id'))
        artist: element.attr('data-artist')
        title: element.attr('data-title')
        url: element.attr('data-url')
        streamUrl: element.attr('data-stream-url')
        originUrl: element.attr('data-origin-url')
        returnUrl: window.location.pathname
      }))
    array

  play: (track) ->
    if track.streamUrl.match(/official\.fm/)
      @activeAudio = @playOfficial(track)
    else if track.streamUrl.match(/soundcloud\.com/)
      @activeAudio = @playSoundcloud(track)
    @notify('play', @playingTrack = track)
    @pausedTrack = null

  playOfficial: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      $(@official).attr('src', track.streamUrl + '?api_key=4qpH1KdXhJF64NPD3zdK7t2gpTF8vHHz')
    @soundcloud.pause()
    @official.play()
    @official

  playSoundcloud: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      $(@soundcloud).attr('src', track.streamUrl + '?client_id=880faec8a616cb8ddc4fc35fe410b644')
    @official.pause()
    @soundcloud.play()
    @soundcloud

  pause: () ->
    @pausedTrack = @playingTrack
    @playingTrack = null
    @activeAudio.pause()
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
