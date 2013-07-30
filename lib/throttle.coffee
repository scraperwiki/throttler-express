exports.throttle = (getIdentifier, timeout = 1000) ->
  cache = {}
  throttleInner = (req, resp, next) ->
    identifier = getIdentifier(arguments)

    previous = cache[identifier] || 0

    now = new Date()
    remaining = timeout - (now - previous)
    if remaining <= 0
      next()
      cache[identifier] = now
    else
      error = new Error("Throttled")
      error.status = 429 # Too Many Requests
      next error

  return throttleInner
