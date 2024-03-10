import pkg/cps
import pkg/uasync
import pkg/uasync/protocols/http/server
import pkg/jsony

import storage

type LogMeta = object
  time: int
  host: string

proc handler(req: Request): Response {.cps: Continuation.} =
  echo req.meth, ' ', req.path
  if req.meth == "GET":
    return Response.status(200)
  if req.meth == "POST" or req.meth == "PUT":
    let storage = newStorage()
    var buf = req.read(1024)
    var line = ""
    while buf.len > 0:
      line.add buf
      var prev = 0
      for i in 0..line.high:
        if line[i] == '\n':
          let json = line[prev..i-1]
          let meta = json.fromJson(LogMeta)
          storage.add(json, meta.time, meta.host)
          prev = i+1
      line = line[prev..^1]
      buf = req.read(1024)
    if line.len > 0:
      let meta = line.fromJson(LogMeta)
      storage.add(line, meta.time, meta.host)
    return Response.status(201)
newHttpServer().listen(8080, whelp handler)

run()
