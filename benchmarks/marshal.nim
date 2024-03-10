import pkg/jsony, json
import pkg/msgpack4nim
import pkg/msgpack4nim/[msgpack2any, msgpack2json]
import pkg/jsmn

import bench

let test = """{"user_id":"cnpTcksoUFZIOzc6bkNDW3Yl","trace_id":"cnpTcksoUFZIOzc6bkNDW3Yl","properties":{"method":"GET","path":"/free_cookies"},"host":"myagent1","service":"cookies","time":12345}"""

let dump = test.fromJson(JsonNode)

bench "jsony":
  discard test.fromJson(JsonNode)

type TimeLog = object
  time: int

bench "jsony.type":
  discard test.fromJson(TimeLog)

let msgpack_buf = msgpack2json.fromJsonNode(dump)

bench "msgpack2json.fromJsonNode":
  discard msgpack2json.fromJsonNode(dump)

bench "msgpack2json.toJsonNode":
  discard msgpack2json.toJsonNode(msgpack_buf)


# let msgpack4nim_buf = pack(json)
bench "msgpack2any.toAny":
  discard msgpack2any.toAny(msgpack_buf)

var tokens = newSeq[JsmnToken](32)

bench "jsmn":
  discard parseJson(test, tokens)

# maybe use simdjson