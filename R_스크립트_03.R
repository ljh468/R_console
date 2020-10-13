DF <- read.csv("example_studentlist.csv")
attach(DF)
DF
str(DF)
plot(age)
plot(height)
#두개의 컬럼의 상관관계
plot(height,weight)
plot(weight~height)

# sex가 char형이므로 factor로 변경
is(sex)
sex <- as.factor(sex)
plot(sex,height)

DF2 <- data.frame(DF$height, DF$weight)
DF2
plot(DF)

DF3 <- cbind(DF2, DF$age)
DF3
plot(DF3)
plot(DF)

# pch는 점의 종류
plot(weight~height, pch=as.integer(sex))

# legend == 범례
legend("topleft", c("남", "여"), pch=DF$sex)
coplot(weight~height|sex)

plot(weight~height, ann=F)
# 그래프 제목
title(main="A대학 B학과생 몸무게와 키의 상관관계")
# x축
title(xlab="몸무게")
# y축
title(ylab="키")
# 눈금표
grid()

# 그래프에 선 긋기
weightMean <- mean(height)
abline(v=weightMean, col="red")

# bar그래프 (명목형변수)
FreqBlood <- table(DF$bloodtype)
FreqBlood
barplot(FreqBlood)

title(main="혈액형별 빈도수")
title(xlab="혈액형")
title(ylab="빈도수")

# 그룹별 평균값 나타내기
DF
Height <- tapply(DF$height, DF$bloodtype, mean)
Height

# ylim == y축의 범위를 정함
barplot(Height, ylim=c(0, 200))
boxplot(height)
boxplot(height~bloodtype

# 막대의 개수를 바꾸고 싶다면 인자를 추가
# x축은 빈도수
hist(height, breaks=10)

# 상대도수밀도
hist(height, breaks=10, prob=T)
# 곡선추가
lines(density(height))

# hist() breaks인자는 위치값을 직접 입력할수 있음
BreakPoint <- seq(min(height), max(height)+7, by=7)
hist(height, breaks=BreakPoint)

# 계급이 서로 다른경우 일일이 입력도 가능 (y축은 밀도로 변화)
DiffPoint <- c(min(height), 165, 170, 175, 180, 185, 190)
hist(height, breaks=DiffPoint)

# 한화면에 여러 그래프 그리기 par함수
par(mfrow=c(2,3))  #2행 3열
plot(weight, height)
plot(sex, height)
barplot(table(bloodtype))
boxplot(height)
boxplot(height~ bloodtype)
hist(height, breaks=10)

# 원래대로 되돌리고 싶으면
par(mfrow=c(1,1))

# 넘겨가며 그래프 보기
sex <- as.factor(sex)
plot(weight~height+age+grade+absence+sex)

# 한그래프에 두 그래프를 겹쳐 나타내기
# runif는 난수를 만드는 함수
# round(숫자형 객체, 자리수) 소수점을 제어
TS1 <- c(round(runif(30)*100))
TS1
TS2 <- c(round(runif(30)*100))
TS2

# 정렬
TS1 <- sort(TS1, decreasing=F)
TS2 <- sort(TS2, decreasing=F)
TS1
TS2
# 그래프와 line() 함수를 이용하여 라인을 추가
plot(TS1,type="l")  # type은 line
lines(TS2, lty="dashed", col="red")

# 겹치는 그래프는 라인 그래프만 허용
x1 <- seq(1, 100, 1)
y1 <- dbinom(x1, 100, 0.25)
x2 <- seq(1, 50, 1)
y2 <- dbinom(x2, 50, 0.5)
plot(x1, y1, type="h", ylim=c(0,0.2))
lines(x2, y2, col="red")

DF1 <- data.frame(x=x1, y=y1, t=1)
DF2 <- data.frame(x=x2, y=y2, t=1)
DF <- rbind(DF1, DF2)
# type=p 는 산점도를 그릴수 있는 타입임
plot(DF$y~DF$x, type="p", pch="DF$t", col=c("red", "blue"))
plot(x1, y1, type="p")
plot(x1, y1, type="l")
plot(x1, y1, type="c")
plot(x1, y1, type="b")
plot(x1, y1, type="o")
plot(x1, y1, type="h")
plot(x1, y1, type="s")

## ggplot2 그래프 그리기
library("ggplot2")
library("ggthemes")
ggplot(data=diamonds,aes(x=carat, y= price, colour=clarity))+geom_point()+theme_wsj()

# plot() 기본함수는 재사용이 안됨
a <- plot(height)
a

# 반복적으로 코딩하지 않아도 되기 때문에 다양하게 시각화 가능
g1 <- ggplot(data=diamonds, aes(x=carat, y=price, colour=clarity))
g2 <- geom_point()
g3 <- theme_wsj()
g1+g2+g3
g1+g2 + theme_bw()

# ggplot의 함수

# 그래프를 그리는 함수는 geom_point(), geom_line(), geom_histogram() (기하객체함수)
DF <- read.csv("example_studentlist.csv")
# colour를 blood를 정의하여 blood별로 그래프가 그려짐
g1 <- ggplot(DF, aes(x=height, y=weight, colour=bloodtype))
# 점을 그리는 point
g1 + geom_point()
# 라인을 그리는 line
g1 + geom_line()
g1 + geom_point()+geom_line()
g1 + geom_line(size=1)+ geom_point(size=10)

# facet_grid()함수 사용하기
# facet_grid()함수는 명목형변수를 기준으로 나눠서 별도의 그래프를 그려줌
# 목적은 level을 기준으로 나눠서 서로 비교하는것임
# 독립변수는 sex x축을 나눠서 각각성별을 나타냄
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(.~sex)
# sex를 y축으로 나눔
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(sex~.)

# scales인자를 이용해 각각의 스케일을 가질수있음
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(sex~.,scale="free")
# facet_grid는 y축에 대해서는 각각의 스케일을 가지는것을 허용하지않음
g1 + geom_point(size=10) + geom_line(size=1) + facet_wrap(~sex,scale="free")

# mpg데이터셋을 이용해 facet_grid() 와 facet_wrap()함수의 차이를 살펴봄
g <- ggplot(mpg, aes(displ, hwy))
g + geom_point()
g + geom_point() + facet_grid(.~class)

# 실린더수(cyl)에 따른 각각의 산점도 그래프를 추가
# x축과 y축의 단위는 바뀔수 없음
# facet_grid()함수는 명목형변수들이 level별로 나눠서 그래프를 보여주는 목적으로 사용됨
g + geom_point(alpha=.3) + facet_grid(cyl~class, scales="free")

# facet_wrap함수의 목적은 각각의 그래프를 모아서 보기위함
g + geom_point(alpha=.3) + facet_wrap(cyl~class, scales="free")
g + geom_point(alpha=.3) + facet_wrap(cyl~class, scales="free", ncol=3)

# geom_bar() 바그래프로 그리기
ggplot(DF, aes(x=bloodtype)) + geom_bar()

# 성별로 막대의 컬러가 나타남 // 성별이 하나의 막대에 누적
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar()

# dodge를 사용하면 성별로 각가 막대로 나타냄
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="dodge")

# indentity를 사용하면 level별로 더해지지않고 겹쳐서 나타냄
ggplot(DF, aes(x=bloodtype, fill=sex)) + geom_bar(position="identity")




