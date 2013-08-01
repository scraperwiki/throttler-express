throttler-express
=================

throttler = require 'throttler-express'

throttler.throttle returns a middleware which throttles
express requests.

A group of requests sharing the same key are rate limited.
Only one request is allowed in a given time period,
subsequent requests in that time period are given a 429
response.

The first argument to throttle is required and is a
function which returns the key identifying the group of
requests that this request belongs to.

app.get '/mypath', throttler.throttle pickURL, (req, resp, next) ->
