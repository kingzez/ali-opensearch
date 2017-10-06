###
  应用处理
###

debuglog = require('debug')('ali-opensearch::models::apps')
assert = require "assert"
_ = require "underscore"
urlUtil = require 'url'
path = require 'path'
Signature = require "../utils/signature"
Tools = require '../utils/tools'

# 获取指定App信息
# @params {String} appName 指定APP名， 如不指定则默认实例化时传入的appName
getApp = (appName, callback) ->
  header = Tools.generateHeader()
  #header['Content-MD5'] = ''
  uri = Tools.generateUri path.join(@URI_PREFIX, appName||@appName)
  header['Authorization'] = Signature.generateAuthorization @GET_HTTP_METHOD, uri, header
  url = urlUtil.resolve @apiURL, uri

  @apiCall url, @GET_HTTP_METHOD, header, null, callback
  return

# 获取所有APP
# @params {Integer} page 必须 取第几页应用列表，该参数值必须大于0，否者会报错
# @params {Integer} size 必须 每页返回的应用个数，该参数值必须大于或等于0，否者会报错
getAllApp = (page, size, callback) ->
  header = Tools.generateHeader()
  #header['Content-MD5'] = ''
  uri = Tools.generateUri path.join(@URI_PREFIX), {page:"#{page}", size:"#{size}"}
  header['Authorization'] = Signature.generateAuthorization @GET_HTTP_METHOD, uri, header
  url = urlUtil.resolve @apiURL, uri

  @apiCall url, @GET_HTTP_METHOD, header, null, callback
  return

module.exports =
  getApp: getApp
  getAllApp: getAllApp
