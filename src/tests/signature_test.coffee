Signature = require "../utils/signature"
Tools = require '../utils/tools'

app_name = 'app_schema_demo'
accessKeyId = '120001234'
accessKeySecret = '5OCGljiVeXLvO49QaEYuYQjUb1HAZQ'
contentType = 'application/json'
date = '2017-08-09T01:54:12Z'
nonce = '150224365226248'
uri = '/v3/openapi/apps/app_schema_demo/search'
paramsStr = 'fetch_fields=name&query=config%3Dformat%3Afulljson%26%26query%3Dname%3A%27%E6%96%87%E6%A1%A3%27%26%26sort%3Did'
mothed = 'GET'

params =
  fetch_fields: 'name'
  query: "config=format:fulljson&&query=name:'文档'&&sort=id"

url = Tools.generateUri(uri, params)
Signature.init(accessKeyId, accessKeySecret)

header = Tools.generateHeader null, contentType, date, nonce
console.dir header
#authorization = Signature.generateAuthorization mothed, "#{uri}?#{paramsStr}", header
authorization = Signature.generateAuthorization mothed, url, header

sign = "EG+VyxqNhSsPgdaFYfl5Wd7Pulo="
console.log sign
console.log url
console.log "#{uri}?#{paramsStr}"
console.log "authorization #{authorization}"

