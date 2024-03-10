import std/[monotimes, times]

template bench*(name: string, body: untyped) = 
  let start = getMonoTime()
  for i in 0..<1000:
    body
  let time = getMonoTime() - start

  echo name, '\t', (1_000_000_000_000 div time.inNanoseconds), '\t', time.inNanoseconds div 1000
