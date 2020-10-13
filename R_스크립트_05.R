TS <- read.csv("example_ts.csv")
TS
library("ggplot2")
library("ggthemes")
ggplot(TS, aes(x=Date, y=Sales)) + geom_line()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line() + geom_point()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line() + geom_point() + theme_light()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line(colour="orange1", size=1) + geom_point(colour="orangered2", size=4) + theme_light()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line(colour="orange1", size=1) + geom_point(colour="orangered2", size=4) + xlab("년도") + ylab("매출") +ggtitle("A기업 월별 매출") + theme_light()
install.packages(c("dplyr", "hflights"))

# data.frame객체의 데이터를 다루기 쉽게 도와주는 패키지
library("dplyr")
library("ggplot2")
library("ggthemes")

DF <- read.csv("example_population_f.csv")
DF <- DF[,-1] # 첫번째 열은 숫자이기 때문에 삭제함
DF <- tbl_df(DF) # dplyr에서 데이터프레임을 다룰 수 있도록 변환
DF

DF2 <- filter(DF, Provinces=="충청북도"|Provinces=="충청남도")
DF2
Graph <- ggplot(DF2, aes(x=City, y=Population, fill=Provinces)) + geom_bar(stat="identity") +theme_wsj()
Graph
GraphReorder <- ggplot(DF2, aes(x=reorder(City, Population), y=Population, fill=Provinces)) + geom_bar(stat="identity") + theme_wsj()
GraphReorder

DF3 <- filter(DF, SexRatio > 1, PersInHou < 2)
Graph <- ggplot(DF3, aes(x=City, y=SexRatio, fill=Provinces)) + geom_bar(stat="identity") + theme_wsj()
Graph

# dplyr패키지를 이용해 필요한 데이터를 만들고 그래프로 나타내기
library("dplyr")
library("ggplot2")
library("ggthemes")
DF <- read.csv("example_population_f.csv")
DF
DF <- DF[,-1] # 불필요한 첫 번째 열은 삭제함
DF <- mutate(DF, SexF = ifelse(SexRatio < 1, "여자비율높음", ifelse(SexRatio > 1, "남자비율높음", "남여비율같음")))
DF
DF$SexF <- factor(DF$SexF)
DF$SexF <- ordered(DF$SexF, c("여자비율높음","남여비율같음","남자비율높음"))
DF$SexF
DF2 <- filter(DF, Provinces=="경기도")
DF2
Graph <- ggplot(DF2, aes(x=City, y=(SexRatio-1), fill=SexF)) + geom_bar(stat="identity", position="identity") + theme_wsj()
Graph
DF <- mutate(DF, SexF = ifelse(SexRatio < 1, "여자비율높음", ifelse(SexRatio > 1, "남자비율높음", "남여비율같음")))












