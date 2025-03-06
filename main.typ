#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/pointless-size:0.1.1": zh

#show: show-cn-fakebold
#set page(flipped: true, margin: (y: 2.5cm + 2em))

#set text(font: ("Times New Roman", "SimSun"))
#show heading.where(level: 1): it => [
  #v(8em)
  #set text(size: zh(-1), weight: "bold")
  #set align(center)
  #block(smallcaps(it.body))
  #align(center)[
    #v(1em)
    #set text(size: zh(-2))
    *（2019 年）*
    #v(8em)
    *中国计算机学会*
  ]
]
#show heading.where(level: 2): it => [
  #pagebreak()
  #set text(size: zh(-1), weight: "bold")
  #set align(center)
  #if calc.odd(counter(heading).get().last()) [
    中国计算机学会推荐国际学术会议
  ] else [
    中国计算机学会推荐国际学术期刊
  ]
  #set text(size: zh(3))
  #v(1em)
  #block("（" + smallcaps(it.body) + "）")
  #counter(heading).step()
]
#show heading.where(level: 3): it => [
  #let arg = calc.rem(counter("").get().last(), 3) + 1
  #if arg > 1 {
    pagebreak()
  }
  #set text(size: zh(3), weight: "bold")
  #(numbering("一、", arg) + numbering("A 类", arg))
  #block(smallcaps(it.body))
  #counter("").step()
]

= 中国计算机学会推荐国际学术会议和期刊目录

#for (sub, sub-name) in (
  DS: "计算机体系结构/并行与分布计算/存储系统",
  NW: "计算机网络",
  SC: "网络与信息安全",
  SE: "软件工程/系统软件/程序设计语言",
  DB: "数据库/数据挖掘/内容检索",
  CT: "计算机科学理论",
  CG: "计算机图形学与多媒体",
  AI: "人工智能",
  HI: "人机交互与普适计算",
  MX: "交叉/综合/新兴",
) {
  for (type, type-name) in (journal: "期刊", conference: "会议") {
    heading(sub-name, depth: 2)
    for class in ("A", "B", "C") {
      [===
      ]
      table(
        align: center + horizon,
        columns: (1fr, 2fr, 6.5fr, 2fr, 4.5fr),
        [序号], type-name + [简称], type-name + [全称], [出版社], [网址],
        ..csv("tsv/" + sub + "/" + type + "/" + class + ".tsv", delimiter: "\t").flatten().map(x => eval(x, mode: "markup")),
      )
    }
  }
}
