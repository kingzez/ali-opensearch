should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
search = new Search(config.options)


describe "test search", ->
  before () ->

  describe "suggest", ->
    it "should suggest opensearch", (done) ->
      search.suggest 'suggest', 'open', '10', (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return