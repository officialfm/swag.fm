 SwagFm.Client = {

  bookmark: function(url, options) {
    $.ajax({
      url: SwagFm.options.siteUrl + '/tracks.json',
      dataType: 'json',
      type: 'POST',
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

};