debuglog = require('debug')('ali-opensearch::models::actions')
assert = require "assert"
_ = require "underscore"
urlUtil = require 'url'
path = require 'path'
Signature = require "../utils/signature"
Tools = require '../utils/tools'

# 提交文档
# @param items [{},{}]
# @param table_name 表名
# @return callback(err, data) data(json格式) 成功：{"status":"OK"} 失败：'{"status":"FAIL","errors":[{"code":4010,"message":"timestamp expired"}],"RequestId":"141344839303112480055370"}'
insert = (items, table_name, callback) ->
  return callback() if _.isEmpty(items)
  assert table_name, "missing table_name"
  assert _.isFunction(callback), "missing callback"
  uri = path.join(@URI_PREFIX, @appName, table_name, "/actions/bulk")
  url = urlUtil.resolve @apiURL, uri
  query = []
  # timestamp TODO 设置文档的发生时间（高级版支持）
  for val in items
    query.push {
      cmd: 'ADD'
      fields:val
    }
  query = JSON.stringify(query)
  header = Tools.generateHeader()
  header['Content-MD5'] = Signature.md5(query)
  header.Authorization = Signature.generateAuthorization @POST_HTTP_METHOD, uri, header
  @apiCall url, @POST_HTTP_METHOD, header, query, callback
  return

module.exports =
  insert: insert
