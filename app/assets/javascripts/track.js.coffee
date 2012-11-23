class @Track
  constructor: (attributes) ->
    @id = attributes['id']
    @url = attributes['url']
    @title = attributes['title']
    @artist = attributes['artist']
    @position= attributes['position']
    @streamUrl = attributes['streamUrl']
    @originUrl= attributes['originUrl']
    @coverUrl = attributes['coverUrl']
    @anchor = attributes['anchor']
    @returnUrl = attributes['returnUrl']

  observe: (name, callback) ->
    @callbacks || (@callbacks = {})
    @callbacks[name] || (@callbacks[name] = [])
    this.callbacks[name].push(callback)

  notify: (name) ->
    if @callbacks && @callbacks[name]
      for callback in @callbacks[name]
        callback.apply(undefined, Array.prototype.slice.call(arguments, 1))
