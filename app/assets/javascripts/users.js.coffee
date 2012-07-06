
class Player
  @add: ->
    url = prompt "Add a new player", "URL of the official.fm page"
    if Player.match(url)
      Player.createPlayer(url)
    else
      alert "This is not an official.fm url!"

  @match: (url) ->
    console.log(url)
    return url.match /official\.fm/

  @createPlayer: (url) ->
    form = $('#create_player')
    form.find('input').val(url)
    form.submit()
    


$(document).ready ->
  $('#add_player').bind 'click', ->
    Player.add()
