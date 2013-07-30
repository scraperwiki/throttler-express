sinon = require 'sinon'
should = require 'should'
throttle = require 'lib/throttle'

describe 'Throttle', ->
  before ->
    @throttleRoute = throttle.throttle (args) -> (args[0].foo)

  context 'First time call', ->
    it 'allows the call', ->
      next = sinon.stub()
      @throttleRoute {foo: 'bar'}, {}, next

      next.called.should.be.true

  context 'Multiple calls (before time elapsed)', ->
    it 'errors the second call', ->
      next = sinon.stub()
      @throttleRoute {foo: 'baz'}, {}, next

      @throttleRoute {foo: 'baz'}, {}, next

      
      next.firstCall.calledWith().should.be.true
      error = new Error("Throttled")
      error.status = 429
      next.secondCall.calledWith(error).should.be.true

  context 'Multiple calls (after time elapsed)', ->
    it 'allows the call', ->
      clock = sinon.useFakeTimers()

      next = sinon.stub()
      @throttleRoute {foo: 'qux'}, {}, next

      clock.tick 2000

      @throttleRoute {foo: 'qux'}, {}, next

      next.callCount.should.equal 2

      clock.restore()
