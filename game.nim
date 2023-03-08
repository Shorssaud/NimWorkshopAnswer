import terminal

const WIDTH = 20
const HEIGHT = 20
var grid: array[HEIGHT, array[WIDTH, bool]]

proc print_grid() =
  for y in 0..<HEIGHT:
    for x in 0..<WIDTH:
      if grid[x][y]:
        setForegroundColor(fgRed)
        stdout.write("X")
      else:
        setForegroundColor(fgWhite)
        stdout.write(".")
    echo ""



proc count_neighbors(x, y: int): int =
  var count = 0
  for i in -1..1:
    for j in -1..1:
      if i == 0 and j == 0:
        continue
      var nx = x + i
      var ny = y + j
      if nx < 0 or ny < 0 or nx >= WIDTH or ny >= HEIGHT:
        continue
      if grid[nx][ny]:
        count += 1
  return count

proc update_grid() =
  var new_grid: array[HEIGHT, array[WIDTH, bool]]
  for x in 0..<WIDTH:
    for y in 0..<HEIGHT:
      var neighbors = count_neighbors(x, y)
      if grid[x][y]:
        new_grid[x][y] = neighbors == 2 or neighbors == 3
      else:
        new_grid[x][y] = neighbors == 3
  grid = new_grid


import std/terminal
import std/os

import strutils

proc read_coords(input: string): (int, int) =
  let parts = input.split(",")
  let x = parseInt(parts[0])
  let y = parseInt(parts[1])
  return (x, y)

while true:
  eraseScreen()
  print_grid()
  echo "Enter coordinates (x,y) to toggle cell state or 'q' to quit:"
  let input = readLine(stdin)
  if input == "q":
    break
  if input == "r":
    while true:
      update_grid()
      eraseScreen()
      print_grid()
      sleep(100)
  let (x, y) = read_coords(input)
  grid[x][y] = not grid[x][y]
  
