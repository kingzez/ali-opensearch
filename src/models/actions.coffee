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
  return callback('missing items') if _.isEmpty(items)
  assert table_name, "missing table_name"
  assert _.isFunction(callback), "missing callback"
  uri = path.join(@URI_PREFIX, @appName, table_name, "/actions/bulk")
  url = urlUtil.resolve @apiURL, uri
  query = []
  # timestamp TODO 设置文档的发生时间（高级版支持）
  for val in items
    query.push {
      cmd: 'add'
      fields:val
    }
  query = JSON.stringify(query)
  header = Tools.generateHeader()
  header['Content-MD5'] = Signature.md5(query)
  header.Authorization = Signature.generateAuthorization @POST_HTTP_METHOD, uri, header
  @apiCall url, @POST_HTTP_METHOD, header, query, callback
  return

# 更新文档（标准版不支持）
# @param items [{},{}]
# @param table_name 表名
# @return callback(err, data) data(json格式) 成功：{"status":"OK"} 失败：'{"status":"FAIL","errors":[{"code":4010,"message":"timestamp expired"}],"RequestId":"141344839303112480055370"}'
update = (items, table_name, callback) ->
  return callback('missing items') if _.isEmpty(items)
  assert table_name, "missing table_name"
  assert _.isFunction(callback), "missing callback"
  uri = path.join(@URI_PREFIX, @appName, table_name, "/actions/bulk")
  url = urlUtil.resolve @apiURL, uri
  query = []
  # timestamp TODO 设置文档的发生时间（高级版支持）
  for val in items
    query.push {
      cmd: 'update'
      fields:val
    }
  query = JSON.stringify(query)
  header = Tools.generateHeader()
  header['Content-MD5'] = Signature.md5(query)
  header['Authorization'] = Signature.generateAuthorization @POST_HTTP_METHOD, uri, header
  @apiCall url, @POST_HTTP_METHOD, header, query, callback
  return

# 删除文档
# @param ids [id,id]
# @param table_name 表名
# @return callback(err, data) data(json格式) 成功：'{"status":"OK","RequestId":"1413451169068930200630477"}' 失败：'{"status":"FAIL","errors":[{"code":4010,"message":"timestamp expired"}],"RequestId":"141344839303112480055370"}'
deleteByIds = (ids, table_name, callback) ->
  return callback('missing ids') if _.isEmpty(ids)
  assert table_name, "missing table_name"
  assert _.isFunction(callback), "missing callback"

  uri = path.join(@URI_PREFIX, @appName, table_name, "/actions/bulk")
  url = urlUtil.resolve @apiURL, uri
  query = []
  ids.map (val) ->
    if _.isObject(val)
      query.push {
        cmd: 'delete'
        fields: val
      }
    else
      query.push {
        cmd: 'delete'
        fields:{
          id:val
        }
      }
  query = JSON.stringify(query)
  header = Tools.generateHeader()
  header['Content-MD5'] = Signature.md5(query)
  header['Authorization'] = Signature.generateAuthorization @POST_HTTP_METHOD, uri, header
  @apiCall url, @POST_HTTP_METHOD, header, query, callback
  return


module.exports =
  insert: insert
  update: update
  deleteByIds: deleteByIds
