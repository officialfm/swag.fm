
$(document).ready ->
  $('#add_player').bind 'click', ->
    url = prompt "Add a new player", "URL of the official.fm page"

    $.ajax '/players',
      type: 'POST',
      data: player: url: url
