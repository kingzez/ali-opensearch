###
  下拉提示
###

debuglog = require('debug')('ali-opensearch::models::suggest')
assert = require "assert"
_ = require "underscore"
urlUtil = require 'url'
path = require 'path'
Signature = require "../utils/signature"
Tools = require '../utils/tools'

# 下拉提示
# @params {String} suggestName 为您的下拉提示名
# @params {String} 搜索关键词（包含中文需进行urlencode编码）
# #params {Integer} hits
suggest = (suggestName, query, hits, callback) ->
  header = Tools.generateHeader()
  #header['Content-MD5'] = ''
  #uri = path.join(@URI_PREFIX, @appName, "/suggest", suggestName, "/search")
  uri = Tools.generateUri path.join(@URI_PREFIX, @appName, "/suggest", suggestName, "/search"), {query:query, hits:"#{hits}"}
  #uri = "/v3/openapi/apps/advanced_text/suggest/suggest/search?query=%E6%A0%87%E9%A2%98&hits=10"
  #console.log "uri: #{uri}"
  header['Authorization'] = Signature.generateAuthorization @GET_HTTP_METHOD, uri, header
  #url = urlUtil.resolve @apiURL, Tools.generateUri uri, {query:query, hits:"#{hits}"}
  url = urlUtil.resolve @apiURL, uri
  @apiCall url, @GET_HTTP_METHOD, header, null, callback
  return

module.exports =
  suggest: suggest
