 SwagFm.Client = {

  bookmark: function(url, options) {
    $.ajax({
      url: SwagFm.options.siteUrl + '/tracks.json',
      dataType: 'json',
      type: 'POST',
      headers: {origin: SwagFm.options.siteUrl},
      data: {player: {url: url}},
      success: options.success,
      error: options.error
    });
  },

  getBoormarks: function(url, options) {
    $.ajax({
      url: SwagFm.options.siteUrl + '/tracks.json',
      dataType: 'json',
      data: { url: url },
      success: options.success,
      error: options.error
    });
  },

  unBookmark: function(trackId, options) {
    $.ajax({
      url: SwagFm.options.siteUrl + '/tracks/' + trackId + '.json',
      dataType: 'json',
      type: 'DELETE',
      success: options.success,
      error: options.error
    });
  },

  login: function(email, password, options) {
    $.ajax({
      url: SwagFm.options.siteUrl + '/session.json',
      dataType: 'json',
      type: 'POST',
      data: { session: { email: email, password: password } },
      success: options.success,
      error: options.error
    });
  }

};