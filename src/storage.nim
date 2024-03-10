type Storage = ref object
  lines: seq[string]

proc newStorage*(): Storage =
  result = new Storage
  result.lines = @[]

proc add*(s: Storage, line: string, time: int, host: string) =
  s.lines.add line
  discard