should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
console.dir Search
search = new Search(config.options)

items = ['001']

items = [
  {identifier:'022'}
]

describe "test delete insert", ->
  before () ->

  describe "delete", ->
    it "should deleteById opensearch", (done) ->
      search.deleteByIds items, 'main', (err, data)->
        if err?
          console.dir err
          return done()
        console.dir data
        done()
        return
      return



