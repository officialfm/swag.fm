
class PlayerCreator
  constructor: ->
    @form = $('#create_player')
    @url = @form.find('input')

  add: ->
    url = prompt "Add a new player", "URL of the official.fm page"
    if @match(url)
      @save(url)
    else
      alert "This is not an official.fm url!"

  match: (url) ->
    return url.match /official\.fm/

  save: (url) ->
    @url.val(url)
    @form.submit()
    


$(document).ready ->
  playerCreator = new PlayerCreator()

  $('#add_player').bind 'click', ->
    playerCreator.add()
