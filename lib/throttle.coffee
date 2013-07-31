exports.throttle = (getIdentifier, timeout = 1000) ->
  cache = {}
  throttleInner = (req, resp, next) ->
    identifier = getIdentifier.apply null, arguments

    previous = cache[identifier] || 0

    now = new Date()
    remaining = timeout - (now - previous)
    if remaining <= 0
      cache[identifier] = now
      next()
    else
      resp.send 429, JSON.stringify error: "Throttled"

  return throttleInner
