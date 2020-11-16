# 전국 연령별 평균 월급조사
DF <- read.csv("example_salary.csv", stringsAsFactors=T,na="-")
head(DF,5)
colnames(DF)

# 변수명을 바꿈
colnames(DF) <-c("age", "salary", "specialSalary", "workingTime", "numberOfWorker", "career", "sex")
str(DF)
detach(DF)
attach(DF)

# 평균 구하기
Mean <- mean(salary,na.rm=T)
Mean

# 중앙값 구하기
Mid <- median(salary,na.rm=T)
Mid

# 범위 구하기
Range <- range(salary,na.rm=T)
Range

# 최대값 찾기
# 50대초반 10년이상 경력인 집단의 월급이 평균 406만원임
w <- which(DF$salary==4064286)
DF[w,]

# 사분위수 구하기
Qnt <- quantile(salary, na.rm=T)
Qnt

# 모두 모아 리스트에 담음
Salary <- list(평균월급=Mean, 중앙값월급=Mid, 월급범위=Range, 월급사분위=Qnt)
Salary

# 그룹별 평균구하기
DF <- read.csv( "example_salary.csv", stringsAsFactors=F, na="-")
head(DF,5)

# 변수명 바꾸기
colnames(DF)
colnames(DF) <- c("age", "salary", "spectialSalary", "workingTime", "numberOfWorket", "career", "sex")
head(DF)

# 성별로 평균월급 구하기
# tapply() 함수는 첫번째 인자를 두번째 인자를 기준으로 세번째인자인 함수로 처리
temp <- tapply(DF$salary, DF$sex, mean, na.rm=T)
temp

library("ggplot2")
install.packages("reshape2")
library("reshape2")
melt <- melt(temp)
ggplot(melt, aes(x=Var1, y=value, fill=Var1)) + geom_bar(stat="identity")


# 표준편차를 구함
tapply(DF$salary, DF$sex, sd, na.rm=T)

# 범위를 구함
tapply(DF$salary, DF$sex, range, na.rm=T)

# 경력별 평균월급을 구함
temp <- tapply(DF$salary, DF$career, mean, na.rm=T)
temp

# 그래프를 그림
melt <- melt(temp)
ggplot(melt, aes(x=Var1, y=value, group=1)) + geom_line(colour="skyblue2", size=2) + coord_polar() + ylim(0, max(melt$value))

# 표준 편차를 구함
tapply(DF$salary, DF$career, sd, na.rm=T)

# 경력별 범위를 구함
tapply(DF$salary, DF$career, range, na.rm=T)

# 가장 적은 월급 집단을 찾음
a1 <- DF[which(DF$salary == 1172399),]
a2 <- DF[which(DF$salary == 1685204),]
a3 <- DF[which(DF$salary == 1117605),]
a4 <- DF[which(DF$salary == 1245540),]
a5 <- DF[which(DF$salary == 1548036),]
list <- list(a1, a2, a3, a4, a5)
list

# 아웃라이어 찾기와 제거하기
# na인자는 어떤값을 NA(결측치)로 사용 할지 정하는 인자임
DF <- read.csv("example_cancer.csv", stringsAsFactors=F, na="기록없음")
str(DF)
attach(DF)
detach(DF)

# 나이의 평균을 구함
mean(age)
summary(age)

# 그래프로 아웃라이어를 찾음
boxplot(age, range=1.5)
grid()

# 먼저 IQR의 길이를 알아냄
distIQR <- IQR(age,na.rm=T)
distIQR

# IQR의 위치를 구함
# quantile() 4분우 지점을 알려주는 함수
# prob인자를 이용하면 원하는 곳의 위치를 알 수 있음
posIQR <- quantile(age, prob=c(0.25, 0.75), na.rm=T)
posIQR

# IQR위치에서 1.5배 더한 위치를 구함
# 25%지점과 75% 지점의 1.5배 연장한 위치의 값을 찾음
DownWhisker <- posIQR[[1]] - distIQR*1.5
UpWhisker <- posIQR[[2]] + distIQR*1.5
DownWhisker; UpWhisker

# 아웃라이어만 따로 저장함
Outlier <- subset(DF, subset=(DF$age < DownWhisker | DF$age > UpWhisker))
Outlier

# 평균값 표준화하여 그래프를 그려 한눈에 보기
DF <- read.csv("example_salary.csv", stringsAsFactors=F, na="-")
head(DF, 5)

# 변수명을 바꿈
colnames(DF) <- c("age", "salary", "specialSalary", "workingTime", "numberOfWorker", "career", "sex")
head(DF, 5)

# 표준화 시킴
# 평균이 0이고 0을 기준으로 분산된 값들이 있음
Scale <- scale(DF$salary)
head(Scale, 10)

# DF객체에 추가함
DF <- cbind(DF, scale= Scale)
str(DF)

# 그래프로 그리기
# 색깔별로 남자와 여자를 알 수 있고 모양에 따라 경력을 알수 있음
# 0을 기준으로 왼쪽은 평균보다 월급을 조금 받는 집단임
g1 <- ggplot(DF, aes(x=scale, y=age))
g2 <- geom_segment(aes(yend=age), xend=0)
g3 <- g1 + g2 + geom_point(size=7, aes(colour=sex, shape=career)) + theme_minimal()
g3


