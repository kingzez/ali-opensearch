should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
console.dir Search
search = new Search(config.options)

items = [
  {
    identifier:'001'
    title:'测试2'
    author:'yxd'
    subject: '阿里云的opensearch 开发测试'
    keywords:'测试，opensearch'
    content: '阿里云的opensearch 开发测试 content'
    creation_date: Date.now()
    modified_date: Date.now()
    format:'json'
  }
]

describe "test search update", ->
  before () ->

  describe "update", ->
    it "should update opensearch", (done) ->
      search.update items, 'main', (err, data)->
        if err?
          console.dir err
          return done()
        console.dir data
        done()
        return
      return



