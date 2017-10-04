should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
search = new Search(config.options)


describe "test apps", ->
  before () ->

  describe "getApp", ->
    it "should getApp opensearch", (done) ->
      search.getApp null, (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

  describe "getApp", ->
    it "should getApp opensearch", (done) ->
      search.getApp 'standard_text', (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

  describe "getAllApp", ->
    it "should getAllApp opensearch", (done) ->
      search.getAllApp 1, 10, (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return