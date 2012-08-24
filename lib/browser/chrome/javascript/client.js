 SwagFm = {
  options: {siteUrl: 'http://0.0.0.0:3000'}
};

 SwagFm.Client = {
  oauth: null,
  
  initOauth: function() {
    this.oauth = ChromeExOAuth.initBackgroundPage({
      'request_url' : SwagFm.options.siteUrl + '/oauth/request_token',
      'authorize_url' : SwagFm.options.siteUrl + '/oauth/authorize',
      'access_url' : SwagFm.options.siteUrl + '/oauth/access_token',
      'consumer_key' : 'anonymous',
      'consumer_secret' : 'anonymous',
      'scope' : SwagFm.options.siteUrl,
      'app_name' : 'Swag.fm Chrome Extension'
    });
  },

  treatResponse: function(responseText, request) {
    console.log(arguments);
  },

  bookmark: function(url, options) {
    this.oauth.sendSignedRequest(
      SwagFm.options.siteUrl + '/tracks.json',
      this.treatResponse.bind(this), {
        method: 'POST',
        body: JSON.stringify({player: {url: url}}),
        headers: {
          'X-Same-Domain': 'true',
          'Content-Type': 'application/json;charset=UTF-8'
      }
    });
  },

  getBoormarks: function(url, options) {
    this.oauth.sendSignedRequest(
      SwagFm.options.siteUrl + '/tracks.json',
      this.treatResponse.bind(this), {
        method: 'GET',
        body: JSON.stringify({url: url}),
        headers: {
          'X-Same-Domain': 'true',
          'Content-Type': 'application/json;charset=UTF-8'
      }
    });
  },

  unBookmark: function(trackId, options) {
    this.oauth.sendSignedRequest(
      SwagFm.options.siteUrl + '/tracks/' + trackId + '.json',
      this.treatResponse.bind(this), {
        method: 'DELETE',
        body: JSON.stringify({player: {url: url}}),
        headers: {
          'X-Same-Domain': 'true',
          'Content-Type': 'application/json;charset=UTF-8'
      }
    });
  }
};
