# 抓取豆瓣top250的电影
# http://movie.douban.com/top250?start=0&filter=&type=
pageno <- seq(0,225, by = 25)
url <- paste0('http://movie.douban.com/top250?start=',pageno,'&filter=&type="')
# 用readLines 比用htmlParse要好，因为XML包中的htmlParse中文存在乱码问题
web <- NULL
for (i in seq(url)){
  sub_web <-readLines(url[i], encoding='UTF-8')
  web <- c(web,sub_web)
}
# 找到包含电影名称的所有行
name <- web[grep('<img alt=',web)]
# 用正则表达式来提取电影名称所在字符的位置和长度
gregout <- gregexpr('alt="(\\w+)"', name)
gregout <- gregexpr('^[\u4e00-\u9fa5]+$','中文123')
# 取满足正则的文本
getcontent <- function(s,g){
  substring(s,g,g+attr(g,'match.length')-1)
}
movie.names <- 0
for (i in seq(name)) {
  movie.names[i] <- getcontent(name[i],gregout[[i]])
}
# 去除alt=字符
movie.names <-gsub('alt=','',movie.names)
movie.names <-gsub('"','',movie.names)


