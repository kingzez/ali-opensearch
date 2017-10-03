###
# User YuanXiangDong
# Date 17-10-01
# aliyun search main V3
# aliyun开放式搜索的接口实现(V3)
###

debuglog = require('debug')('ali-opensearch::search')
assert = require "assert"
Tools = require './utils/tools'
_ = require "underscore"
request = require 'request'


class Search

  ###
  # @param options:{}
  #   accessKeyId, 必须
  #   accessKeySecret, 必须
  #   apiURL，接口域名， 必须
  #   appName 开放搜索的应用名，必须, 如果不传，则只能使用models/app 模块
  #   pageSize 单页结果数量，默认40条
  #   format   返回数据的格式，默认JSON（有xml、json、fulljson三种格式可选。）
  #   timeout 默认3000
  ###
  constructor : (searchOptions) ->
    assert searchOptions, "missing options"
    assert searchOptions.accessKeyId, "missing opensearch key id"
    assert searchOptions.accessKeySecret, "missing opensearch key secret"
    @GET_HTTP_METHOD = "GET"
    @POST_HTTP_METHOD = "POST"
    @SEARCH_LIST_SIZE = 40
    @URI_PREFIX = '/v3/openapi/apps'
    @CONTENT_TYPE = 'application/json'
    @version = 'v3'

    @accessKeyId = searchOptions.accessKeyId
    @accessKeySecret = searchOptions.accessKeySecret
    @apiURL = searchOptions.apiURL || 'http://opensearch-cn-hangzhou.aliyuncs.com'
    @appName = searchOptions.appName
    @pageSize = searchOptions.pageSize || @SEARCH_LIST_SIZE
    @format = searchOptions.format || 'json'
    @timeout = searchOptions.timeout || 3000
    require('./utils/signature').init(@accessKeyId, @accessKeySecret)
    @mixin(require('./models/actions'))
    @mixin(require('./models/searchs'))
    return

  mixin: (obj) ->
    for key, v of obj
      @[key] = v
    return

  apiCall : (url, httpMethod, httpHeader, form, callback) ->
    options =
      url: "#{url}"
      method:httpMethod
      timeout: @timeout
      headers: httpHeader
    options.body = form if form?
    console.dir options
    request(options, (err, res, body) =>
      body = Tools.parseResult(body)
      callback err, body
      return
    )
    return

  module.exports = Search