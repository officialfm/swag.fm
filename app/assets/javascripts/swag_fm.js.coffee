class @SwagFm
  constructor: () ->
    @player = new Player()
    @gallery = new Gallery(@player)
    @controller = new Controller(@player)
    @autoPlay()

  pageChanged: () ->
    @gallery.initializeEvents()
    @controller.initializeEvents()

  autoPlay: () ->
    if window.location.hash && $(window.location.hash)[0]
      @player.play(@player.findTrackByAnchor(window.location.hash.replace('#', '')))
