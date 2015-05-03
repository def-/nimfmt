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
