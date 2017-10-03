debuglog = require('debug')('ali-opensearch::utils::signature')
crypto = require 'crypto'

ACCESS_KEY_ID = null
ACCESS_KEY_SECRET = null

init = (accessKeyId, accessKeySecret) ->
  ACCESS_KEY_ID = accessKeyId
  ACCESS_KEY_SECRET = accessKeySecret

md5 = (str) ->
  console.log "str: #{str}"
  md5sum = crypto.createHash 'md5'
  md5sum.update str, Buffer.isBuffer(str) ? 'binary' : 'utf8'
  return md5sum.digest 'hex'

makeSignature = (mothed, uri, request_header) ->
  params = [mothed]
  params.push request_header['Content-MD5']
  params.push request_header['Content-Type']
  params.push request_header['Date']
  params.push "x-opensearch-nonce:#{request_header['X-Opensearch-Nonce']}"
  params.push uri
  console.dir params
  #return crypto.createHmac('sha1', ACCESS_KEY_SECRET).update(params.join('\n')).digest('base64')
  return crypto.createHmac('sha1', ACCESS_KEY_SECRET).update(params.join('\n')).digest().toString('base64')

generateAuthorization = (mothed, uri, request_header) ->
  return "OPENSEARCH #{ACCESS_KEY_ID}:#{makeSignature(mothed, uri, request_header)}"

getAuthorization = (signature) ->
  return "OPENSEARCH #{ACCESS_KEY_ID}:#{signature}"

module.exports = exports =
  init: init
  md5: md5
  makeSignature: makeSignature
  generateAuthorization: generateAuthorization
  getAuthorization: getAuthorization