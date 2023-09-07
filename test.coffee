#!/usr/bin/env coffee

getRowAndRemain = (li, width) ->
  row = []
  remain = li.slice()

  left = 0
  right = 0
  currentSum = 0
  maxSum = 0

  while right < li.length
    if currentSum + li[right] <= width
      currentSum += li[right]
      right += 1
    else
      if currentSum > maxSum
        maxSum = currentSum
        row = li.slice(left, right)
      currentSum -= li[left]
      left += 1

  if currentSum > maxSum
    row = li.slice(left, right)

  remain = remain.filter (item) -> row.indexOf(item) == -1

  return { row: row, remain: remain }

# 示例输入
li = [3, 9, 2, 1, 5, 1, 7, 4]
width = 10

result = getRowAndRemain(li, width)
console.log "Row: ", result.row
console.log "Remain: ", result.remain

