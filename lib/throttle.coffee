exports.throttle = (getKey, timeout = 1000) ->
  throttled = {}

  throttleInner = (req, resp, next) ->
    key = getKey.apply null, arguments
    if throttled[key]
      return resp.send 429, JSON.stringify error: "Throttled"

    throttled[key] = true
    setTimeout =>
      delete throttled[key]
    , timeout

    next()

  return throttleInner
