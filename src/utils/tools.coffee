debuglog = require('debug')('ali-opensearch::utils::tools')
_ = require 'underscore'
crypto = require 'crypto'
urlUtil = require 'url'
urlEncode = require './url_encode'

Date.prototype.Format = (fmt) ->
  o = {
    "M+" : this.getMonth()+1,                 #//月份
    "d+" : this.getDate(),                    #//日
    "h+" : this.getHours(),                   #//小时
    "m+" : this.getMinutes(),                 #//分
    "s+" : this.getSeconds(),                 #//秒
    "q+" : Math.floor((this.getMonth()+3)/3), #//季度
    "S"  : this.getMilliseconds()             #//毫秒
  }
  if(/(y+)/.test(fmt))
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length))
  for k, val of o
    if(new RegExp("(#{k})").test(fmt))
      fmt = fmt.replace(RegExp.$1, if RegExp.$1.length==1 then (o[k]) else (("00"+ o[k]).substr((""+ o[k]).length)))
  return fmt

generateNonce = (date) ->
  return String(Math.floor(date.getTime()/1000)) + String(Math.round(Math.random()*89999+10000))

generateHeader = (query, contentType, date, nonce) ->
  date or= new Date(new Date().getTime()-28800000)
  header =
    "Date": date.Format("yyyy-MM-ddThh:mm:ssZ")
    "Content-Type": contentType || 'application/json'
    "X-Opensearch-Nonce": nonce || generateNonce(date)
  #if query?
  #  console.log "query: %s", query
  #  header["Content-MD5"] = crypto.createHash('md5').update(query).digest('hex')
  #else
  #  header["Content-MD5"] = ''
  return header

generateUri = (uri, http_params) ->
  return "#{uri}?#{urlEncode.query2string(http_params)}"

parseResult = (data, page, pageSize) ->
  return data unless data
  data = JSON.parse(data)
  return data unless page?
  return data unless data.status is 'OK'
  result = data.result
  return data unless result
  result['page'] = page
  result['pagetotal'] =  parseInt((result.viewtotal+ pageSize - 1)/ pageSize)
  data.result = result
  return data

console.log generateNonce(new Date())

module.exports = exports =
  generateNonce: generateNonce
  generateHeader: generateHeader
  generateUri: generateUri
  parseResult: parseResult
