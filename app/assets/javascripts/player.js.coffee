class @Player
  constructor: () ->
    @official = document.createElement('audio')
    @soundcloud = document.createElement('audio')
    $(@official).on('ended', @playNextTrack.bind(this))
    $(@soundcloud).on('ended', @playNextTrack.bind(this))
    window.onYouTubePlayerReady = @onYouTubePlayerReady.bind(this)
    window.onYouTubeStateChanged = @onYouTubeStateChanged.bind(this)
    @youtube = new YoutubeWrapper()
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
      @play(@findTrackByAnchor(window.location.hash.replace('#', '')))

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
        position: element.attr('data-position')
        returnUrl: window.location.pathname
      }))
    array

  swapTracks: (track1, track2) ->
    index1 = @tracks().indexOf(track1)
    index2 = @tracks().indexOf(track2)
    @tracks()[index2] = track1
    @tracks()[index1] = track2
    for track in @tracks() 
      track.position = @tracks().indexOf(track) + 1

  play: (track) ->
    if track.streamUrl.match(/official\.fm/)
      @activeAudio = @playOfficial(track)
    else if track.streamUrl.match(/soundcloud\.com/)
      @activeAudio = @playSoundcloud(track)
    else if track.streamUrl.match(/youtube\.com/)
      @activeAudio = @playYoutube(track)
    @notify('play', @playingTrack = track)
    @pausedTrack = null

  playOfficial: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      $(@official).attr('src', track.streamUrl + '&api_key=4qpH1KdXhJF64NPD3zdK7t2gpTF8vHHz')
    @soundcloud.pause()
    @youtube.pause()
    @official.play()
    @official

  playSoundcloud: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      $(@soundcloud).attr('src', track.streamUrl + '?client_id=880faec8a616cb8ddc4fc35fe410b644')
    @official.pause()
    @youtube.pause()
    @soundcloud.play()
    @soundcloud

  playYoutube: (track) ->
    if (track != @playingTrack && track != @pausedTrack)
      @youtube.playUrl(track.streamUrl)
    @official.pause()
    @soundcloud.pause()
    @youtube.play()
    @youtube

  onYouTubePlayerReady: (playerId) ->
    @youtube.object.addEventListener("onStateChange", "onYouTubeStateChanged")

  onYouTubeStateChanged: (state) ->
    @playNextTrack() if state == 0

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

# Goal is to provide same interface as audio HTML5 element.
class YoutubeWrapper
  constructor: () ->
    @object = document.createElement('object')
    @object.setAttribute('type', "application/x-shockwave-flash")
    @object.setAttribute('id', "youtube-player")
    @object.setAttribute('width', 200)
    @object.setAttribute('height', 200)
    @object.setAttribute('data', "http://www.youtube.com/apiplayer?controls=0&rel=0&showinfo=0&version=3&enablejsapi=1&playerapiid=youtube-player")
    @object.appendChild(param = document.createElement('param'))
    param.setAttribute("name", "allowScriptAccess")
    param.setAttribute("value", "always")
    document.body.parentElement.appendChild(@object) # Attach to HTML to prevents turbolinks from replacing the flash embed.

  play: -> @object.playVideo() if @object.playVideo
  pause: -> @object.pauseVideo() if @object.pauseVideo

  playUrl: (url) ->
    if @object.loadVideoByUrl
      @object.loadVideoByUrl(url)
    else
      setTimeout((=> @playUrl(url)), 500)
