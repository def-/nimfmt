# This is a very simple try of getting a gofmt like tool for Nim. The idea is
# to use the Nim compiler's parser and renderer. This seems to work reasonably
# well. The next steps are:
#
# 1. Fix the formatted files so they work
# 2. Improve the renderer's style
# 3. Make the renderer configurable

import os, strutils, compiler/parser, compiler/renderer

let
  input = paramStr(1)
  (dir, name, ext) = splitFile input
  output = dir / name & "_pretty" & ext

var
  ast = parseString readFile paramStr(1)
  str = ""

for line in splitLines renderTree ast:
  str.add line[2..^1].strip(leading = false)
  if str.len > 0:
    str.add "\n"

output.writeFile str
