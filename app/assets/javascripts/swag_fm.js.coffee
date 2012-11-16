class @SwagFm
  constructor: () ->
    @player = new Player()
    @gallery = new Gallery(@player)
    @controller = new Controller(@player)

  pageChanged: () ->
    @gallery.initializeEvents()
    @controller.initializeEvents()
