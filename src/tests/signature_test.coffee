Signature = require "../utils/signature"
Tools = require '../utils/tools'

app_name = 'app_schema_demo'
accessKeyId = '120001234'
accessKeySecret = '5OCGljiVeXLvO49QaEYuYQjUb1HAZQ'
contentType = 'application/json'
date = '2018-01-12T09:17:03Z'
nonce = '151571981757920'
uri = '/v3/openapi/apps/wkf_contact_stage/main/actions/bulk'
paramsStr = 'fetch_fields=name&query=config%3Dformat%3Afulljson%26%26query%3Dname%3A%27%E6%96%87%E6%A1%A3%27%26%26sort%3Did'
mothed = 'POST'

params =
  fetch_fields: 'name'
  query: "config=format:fulljson&&query=name:'文档'&&sort=id"

url = Tools.generateUri(uri, params)
Signature.init(accessKeyId, accessKeySecret)

#header = Tools.generateHeader() #null, contentType, date, nonce
#console.dir header
header =
  'Date': date
  'Content-Type':contentType
  'X-Opensearch-Nonce': nonce
  'Content-MD5': '5c0a6422877cbaa2de69676c6a1dc7d1'

console.dir header

#authorization = Signature.generateAuthorization mothed, "#{uri}?#{paramsStr}", header
authorization = Signature.generateAuthorization mothed, uri, header

console.log "authorization: #{authorization}"
return

sign = "EG+VyxqNhSsPgdaFYfl5Wd7Pulo="
console.log sign
console.log url
console.log "#{uri}?#{paramsStr}"
console.log "authorization #{authorization}"

