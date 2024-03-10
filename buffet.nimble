# Package

version       = "0.1.0"
author        = "dterlyakhin"
description   = "log collector"
license       = "MIT"
srcDir        = "src"
bin           = @["buffet"]


# Dependencies

requires "nim >= 2.1.1"
requires "https://github.com/nim-works/cps"
requires "https://github.com/blackmius/uasync/tree/cps"
