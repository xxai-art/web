#!/usr/bin/env coffee

###
每次返回32张图

每次31个序列，加上默认全局流，就是32个序列，每个序列每次随机抽取其中一个推荐流。

序列按最后一次点击时间划分区间，长为

chatgpt编码器提示词： https://chat.openai.com/share/daa45d11-63bb-48a9-8b57-778d782ab892

修正的斐波那契数列，每一项都是前两项和的0.94次方并round，第一项和第二项都是1，给我这个序列的前31项，一行一个，并在最后给我总和

###

连和序 = (项数,幂) =>
  [第一项,第二项] = 数列 = [1,2]
  i = 2
  while i < 项数
    下一项 = Math.round(Math.pow(第一项 + 第二项, 幂))
    数列.push 下一项
    第一项 = 第二项
    第二项 = 下一项
    i += 1

  return 数列

连和序区间 = 连和序(41,0.91)

< (列, 删) =>
  返 = []
  起 = 0

  for 长 in 连和序区间
    终 = 起 + 长
    {length} = 切 = 列.slice(起, 终)
    if length == 0
      return 返
    n = Math.floor(Math.random() * 长)
    if n >= length # 最后一个区间因为不完整可能不会出现
      break
    起 = 终
    返.push(切[n])

  if 终 < 列.length
    删 列.slice(终)
  return 返

# console.log main([1,2,3,4,5,6,7,8,9,10,11,12],=>)
