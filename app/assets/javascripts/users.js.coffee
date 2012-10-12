
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
    data: {url: url})

  onSuccess: (response) ->
    tracks = $('.tracks')
    tracks[tracks.size() - 1].insertBefore($(response)[0])

  onError: (response) ->
    debugger

$(document).ready ->
  playerCreator = new PlayerCreator()

  $('#add-button').bind 'click', ->
    playerCreator.add()
