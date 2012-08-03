
class PlayerCreator
  constructor: ->
    @form = $('#create_player')
    @url = @form.find('input')

  add: ->
    url = prompt "Copy and paste a track URL from official.fm"
    if @match(url)
      @save(url)
    else
      alert "This is not an official.fm url!"

  match: (url) ->
    return url.match /official\.fm/

  save: (url) ->
    $.ajax('/tracks', type: 'POST', success: @onSuccess.bind(this), error: @onError.bind(this),
    data: {player: {url: url}})

  onSuccess: (response) ->
    $(response).insertBefore('.tracks .new')

  onError: (response) ->
    debugger

$(document).ready ->
  playerCreator = new PlayerCreator()

  $('#add_player').bind 'click', ->
    playerCreator.add()
