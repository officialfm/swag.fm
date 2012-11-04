
class PlayerCreator
  constructor: ->
    @form = $('#create_player')
    @url = @form.find('input')

  add: ->
    url = prompt "Copy a track URL from official.fm or soundcloud.com."
    if @match(url)
      @save(url)
    else
      alert "This is neither a URL from official.fm not soundcloud.com."

  match: (url) ->
    return url.match(/official\.fm/) || url.match(/soundcloud\.com/)

  save: (url) ->
    $.ajax('/favorites', type: 'POST', success: @onSuccess.bind(this), error: @onError.bind(this),
    data: {url: url})

  onSuccess: (response) ->
    tracks = $('.tracks')[0]
    tracks.insertBefore($(response)[0], tracks.firstChild)
    $('.blank.slate').remove()

  onError: (response) ->
    debugger

$(document).ready ->
  playerCreator = new PlayerCreator()

  $('#add-button').bind 'click', ->
    playerCreator.add()
