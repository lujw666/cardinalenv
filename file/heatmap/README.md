# heatmap

## 基本介绍

```
脚本名:heatmap
版本号:1.0.2
编程语言:R
依赖库包:argparse
依赖镜像:lumingos≥1.7.1
```

## 功能介绍

1. 读取excel表格热图可视化

## 使用介绍

1. heatmap命令行

```
-h	--help	帮助
-n NAME	--name NAME	文件名
-s SCALE	--scale SCALE	归一化模式row/col/none
-c COL	--col 配色设置
-m MAIN	--main MAIN	标题
-t TYPE	--type TYPE	图片格式
-cr	--clusterrows	是否横聚类
-cc	--clustercols	是否纵聚类
-sr	--showrownames	是否显示行名
-sc	--showcolnames	是否显示列名
-le	--legend	是否显示图例
-l	--log	是否log处理
-gr GAPSROW	--gapsrow GAPSROW	列分区位置
-gc GAPSCOL	--gapscol GAPSCOL	行分区位置
-rg ROWGROUP	--rowgroup ROWGROUP	列标注数量
-cg COLGROUP	--colgroup COLGROUP	行标注数量
-tr CUTREEROWS	--cutreerows CUTREEROWS	列分块数量
-tc CUTREECOLS	--cutreecols CUTREECOLS	行分块数量
```

## 版本迭代

### 1.0.2
1. 增加颜色选项

### 1.0.1
1. 修复main参数不可用
2. 修改T及F为true及false

### 1.0.0
1. 热图脚本基础功能封装

