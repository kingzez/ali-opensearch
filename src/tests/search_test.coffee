should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
console.dir Search
search = new Search(config.options)
console.dir search
describe "test search", ->
  before () ->

  describe "searchById", ->
    it "should searchById opensearch", (done) ->
      search.searchById '001', null, null, (err, result) ->
        if err?
          console.dir err
          return done()
        console.dir result
        return done()
      return
