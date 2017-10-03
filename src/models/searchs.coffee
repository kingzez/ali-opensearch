debuglog = require('debug')('ali-opensearch::models::actions')
assert = require "assert"
_ = require "underscore"
urlUtil = require 'url'
path = require 'path'
Signature = require "../utils/signature"
Tools = require '../utils/tools'

# 搜索文档(按id主键进行的搜索，所以没有分页和过滤)
# @public
# @param {String} id 主键的值
# @param {String} fields 指定返回的字段 可以为Null(为Null,表示不进行过滤)
# @param {String} format 返回数据格式（默认json）
# @return callback(err, data)
#   data(json格式)  成功：'{"status":"OK","result":{"searchtime":0.008163,"total":3,"num":3,"viewtotal":3,"items":[{"id":"bbbbbb","title":"zhe li shi yi ge biao ti 003","owner_id":"GO2SIsP","desc":"这里是文档的详细内容","model_name":"iconpack","index_name":"test"},{"id":"ccccccc","title":"zhe li shi yi ge biao ti 005","owner_id":"GO2SIsP","desc":"这里是文档的详细内容","model_name":"iconpack","index_name":"test"},{"id":"aaaaaaaa","title":"zhe li shi yi ge biao ti 002","owner_id":"GO2SIsP","desc":"这里是文档的详细内容","model_name":"iconpack","index_name":"test"}],"facet":[]},"errors":[],"tracer":""}'
#         失败：'{"status":"FAIL","errors":[{"code":4010,"message":"timestamp expired"}],"RequestId":"141344839303112480055370"}'
searchById = (id, fields, format, callback) ->
  params = {}
  params['fetch_fields'] = fields if fields?
  params['query'] = "config=fromat:#{format||'json'},start:0,hit:#{@pageSize}&&query=id:'#{id}'"
  header = Tools.generateHeader()
  header['Content-MD5'] = ''
  uri = Tools.generateUri path.join(@URI_PREFIX, @appName, "/search"), params
  signature = Signature.makeSignature @GET_HTTP_METHOD, uri, header
  header.Authorization = Signature.getAuthorization(signature)
  url = urlUtil.resolve @apiURL, uri
  options =
    url: url
    method: @GET_HTTP_METHOD
    timeout: @timeout
  @apiCall url, @GET_HTTP_METHOD, header, null, callback
  return

module.exports =
  searchById: searchById