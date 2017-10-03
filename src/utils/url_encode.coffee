###
# User YuanXiangDong
# Date 17-10-2
# url parmas encode util
###

debug = require('debug')('ali-opensearch::utils::url_encode')

dontNeedEncoding = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_.~'
###
params = ['GET',
  '',
  'application/json',
  '2017-08-09T01:54:12Z',
  'x-opensearch-nonce:150224365226248',
  '/v3/openapi/apps/app_schema_demo/search?fetch_fields=name&query=config%3Dformat%3Afulljson&&query%3Dname%3A%27%E6%96%87%E6%A1%A3%27&&sort%3Did']
console.log ACCESS_KEY_SECRET
###
#URL encoding
exports.encode = (str) ->
  out = []
  for i in [0...str.length]
    char = str[i]
    if dontNeedEncoding.indexOf(char) >= 0
      out.push char
    else
      buf = new Buffer(char).toString('hex').toUpperCase()
      jlen = buf.length/2
      for j in [0...jlen]
        out.push "%#{buf.substring(j*2, (j+1)*2)}"
  s = out.join('')
  return s

#将所需的参数装换为URL String
exports.query2string = (params) ->
  str = ''
  for key, val of params
    console.log "key: #{key} val:#{val}"
    str += "#{exports.encode(key)}=#{exports.encode(val)}&"
  str = str.substring(0, str.length-1)#+exports.encode("的")
  return str


#将所需的参数装换为URL encoding Object
exports.query2query = (params) ->
  p = {}
  for key, val of params
    p[exports.encode(key)] = "#{exports.encode(val)}"
  return p
