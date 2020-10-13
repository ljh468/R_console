library("data.table")
DF <- fread("example_studentlist.csv",data.table=F)
detach(DF)
attach(DF)
mean(height, na.rm=T)
median(height, na.rm=T)
range(height, na.rm=T)
quantile(height, na.rm=T)
IQR(height, na.rm=T)
summary(height, na,rm=T)
boxplot(height)
cor(height, weight)
cor.test(height,weight)
cor(DF[,c(3,7,8)])
cor(height, weight, use="complete.obs")
DF2 <- DF
DF2[2,7] <- NA
DF2[4,8] <- NA
DF2
attach(DF2)
cor(height, weight)
cor(height, weight, use="complete.obs")
cor(height, weight, use="everything")
cor(height, weight, use="all.obs")
var(height, na.rm=T)
var(height, weight, na.rm=T)
var(DF[,c(3,7,8)],na.rm=T)
sd(height, na.rm=T)
scale(height)
sd(height)/mean(height)

DF <- read.csv("example_salary.csv", stringsAsFactors=T,na="-")
head(DF,5)
colnames(DF)
colnames(DF) <-c("age", "salary", "specialSalary", "workingTime", "numberOfWorker", "career", "sex")
str(DF)
attach(DF)
Mean <- mean(salary,na.rm=T)
Mid <- median(salary,na.rm=T)
Range <- range(salary,na.rm=T)
w <- which(DF$salary==4064286)
DF[w,]
Qnt <- quantile(salary, na.rm=T)
Salary <- list(평균월급=Mean, 중앙값월급=Mid, 월급범위=Range, 월급사분위=Qnt)
Salary
DF <- read.csv( "example_salary.csv", stringsAsFactors=F, na="-")
head(DF,5)
colnames(DF)
colnames(DF) <- c("age", "salary", "spectialSalary", "workingTime", "numberOfWorket", "career", "sex")

temp <- tapply(DF$salary, DF$sex, mean, na.rm=T)
temp

library("ggplot2")
install.packages("reshape2")
library("reshape2")

melt <- melt(temp)
ggplot(melt, aes(x=Var1, y=value, fill=Var1)) + geom_bar(stat="identity")
tapply(DF$salary, DF$sex, sd, na.rm=T)
tapply(DF$salary, DF$sex, range, na.rm=T)

temp <- tapply(DF$salary, DF$career, mean, na.rm=T)
temp

melt <- melt(temp)
ggplot(melt, aes(x=Var1, y=value, group=1)) + geom_line(colour="skyblue2", size=2) + coord_polar() + ylim(0, max(melt$value))
tapply(DF$salary, DF$career, sd, na.rm=T)
tapply(DF$salary, DF$career, range, na.rm=T)
a1 <- DF[which(DF$salary == 1172399),]
a2 <- DF[which(DF$salary == 1685204),]
a3 <- DF[which(DF$salary == 1117605),]
a4 <- DF[which(DF$salary == 1245540),]
a5 <- DF[which(DF$salary == 1548036),]
list <- list(a1, a2, a3, a4, a5)
list
DF <- read.csv("example_cancer.csv", stringsAsFactors=F, na="기록없음")
str(DF)
attach(DF)
detach(DF)
attach(mtcars)

mean(age)
summary(age)

boxplot(age, range=1.5)
grid()

distIQR <- IQR(age,na.rm=T)
distIQR
posIQR <- quantile(age, prob=c(0.25, 0.75), na.rm=T)
posIQR

DownWhisker <- posIQR[[1]] - distIQR*1.5
UpWhisker <- posIQR[[2]] + distIQR*1.5
DownWhisker; UpWhisker
Outlier <- subset(DF, subset=(DF$age < DownWhisker | DF$age > UpWhisker))
Outlier

DF <- read.csv("example_salary.csv", stringsAsFactors=F, na="-")
head(DF, 5)

colnames(DF) <- c("age", "salary", "specialSalary", "workingTime", "numberOfWorker", "career", "sex")
Scale <- scale(DF$salary)
head(Scale, 10)
DF <- cbind(DF, scale= Scale)
str(DF)
g1 <- ggplot(DF, aes(x=scale, y=age))
g2 <- geom_segment(aes(yend=age), xend=0)
g3 <- g1 + g2 + geom_point(size=7, aes(colour=sex, shape=career)) + theme_minimal()
g3