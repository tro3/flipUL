p = console.log

describe "flipUL", ->
  flipUL = null

  beforeEach ->
    module('flipUL')
#    inject (_flipUL_) ->
#      flipUL = _flipUL_
        
  it "loads", ->
    assert.ok 1
