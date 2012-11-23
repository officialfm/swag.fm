class @Controller
  constructor: (@player) ->
    $(window).keydown(@keyPressed.bind(this))
    @player.observe('play', @play.bind(this))
    @player.observe('pause', @play.bind(this))
    @initializeEvents()

  initializeEvents: () ->
    @initializeCurrentTrack(@player.playingTrack) if @player.playingTrack
    @playButton().on('click', @clickOnPlayButton.bind(this))
    @nextButton().on('click', @clickOnNextButton.bind(this))
    @previousButton().on('click', @clickOnPreviousButton.bind(this))
    $('#add-button').on('click', @clickOnAddButton.bind(this))

  initializeCurrentTrack: (track) ->
    $('#current-track').text(track.title + ' - ' + track.title)
    $('#current-track')[0].href = track.returnUrl + '#' + track.anchor

  play: (track) ->
    @playButton().removeClass('play')
    @playButton().addClass('pause')
    @initializeCurrentTrack(track)

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
    @player.togglePlayback()

  clickOnNextButton: () ->
    @playNextTrack()

  clickOnPreviousButton: () ->
    @player.playPreviousTrack()

  clickOnAddButton: ->
    url = prompt("Copy a track URL from official.fm or soundcloud.com.")
    if url
      if url.match(/official\.fm/) || url.match(/soundcloud\.com/) || url.match(/youtube\.com/)
        @addTrack(url)
      else
        alert("This is neither a URL from official.fm not soundcloud.com.")

  addTrack: (url) ->
    $.ajax('/favorites', type: 'POST', data: {url: url}, success: (response) =>
      $('.tracks')[0].insertBefore($(response)[0], $('.track')[0])
      $('.blank.slate').remove()
    )

  playNextTrack: () ->
    @player.playNextTrack()#(@player.nextTrack() || @player.tracks[0])

  playPreviousTrack: () ->
    @player.playPreviousTrack()
