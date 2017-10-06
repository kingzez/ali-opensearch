should = require "should"
_ = require 'underscore'
config = require('./config')
Search = require '../search'
console.dir Search
search = new Search(config.options)
console.dir search

fields = "identifier;title;author;subject;keywords"
fields = ['identifier','title','author','subject','content','keywords','creation_date']
ids = "001;002;003;010"
ids = ['001','002','003','010']

query = "title:'测试'"
filter = "creation_date>100000"
configs =
  start:0
  hit:20
summary =
  summary_field:'content'
  summary_element:'stong'
  summary_snipped:1

sort = "-creation_date"

querys =
  query: query
  filter: filter
  config: configs
  sort: sort

describe "test search", ->
  before () ->

  describe "searchById", ->
    it "should searchById opensearch", (done) ->
      search.searchById '011', fields, null, (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

  describe "searchByMultipleId", ->
    it "should searchByMultipleId opensearch", (done) ->
      search.searchByMultipleId ids, fields, filter, 'xml', (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

  describe "search", ->
    it "should search opensearch", (done) ->
      search.search query, fields, filter, configs, sort, null, null, summary, (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

  describe "advancedSearch", ->
    it "should advancedSearch opensearch", (done) ->
      search.advancedSearch querys, fields, summary, null, null, null, null, (err, result) ->
        if err?
          console.dir err
          return done()
        console.log "%j", result
        return done()
      return

