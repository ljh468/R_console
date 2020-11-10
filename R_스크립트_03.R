 

 # 데이터셋 패키지 불러오기
install.packages("hflights")
library("hflights")
head(hflights,5)
str(hflights)

CountOfDest <- table(hflights$Dest)
CountOfDest

# 명목형 변수 개수 세기 (몇개의 원소가 있는지 알 수 있음)
length(CountOfDest)
# 가장 작은 값과 가장 큰값을 알려줌
range(CountOfDest)

# 최소값과 최대값의 이름찾기
CountOfDest[CountOfDest==1]
CountOfDest[CountOfDest==9820]

# 6000횟수가 넘는 공항 찾기
SelectedDest <- CountOfDest[CountOfDest > 6000]
SelectedDest

# 6000횟수가 넘는 공항들의 전체 합 구하기
addmargins(SelectedDest,margin=1)
# 막대그래프 그리기
barplot(SelectedDest)

# 대장암 환자 자료 분석
DF <- read.csv("example_cancer.csv")
DF
str(DF)

# 연령대별로 도수값을 구함
# cut() 연령대별로 나눔, breaks() 1부터 11까지 *10-- 10~110까지임
DegreeOfAge <- table(cut(DF$age, breaks=(1:11)*10))
DegreeOfAge

# 열의 이름을 바꿈
rownames(DegreeOfAge) <- c("10s", "20s", "30s", "40s", "50s", "60s", "70s", "80s", "90s", "100s")
DegreeOfAge

# 시각화 시킴
library("ggplot2")
library("ggthemes")
ggplot(data=DF, aes(x=age)) + geom_freqpoly(binwidth=10, size=1.4, colour="orange") + theme_wsj()

install.packages("data.table")
library("data.table")
library("ggplot2")

# read.csv 보다 빠른 fread()로 데이터를 불러옴
# fread는 data.table패키지의 함수임 관측치가 많고 데이터가 큰경우 fread로 불러옴
DF <- fread("example_coffee.csv", header=T, stringsAsFactors=T,data.table=F)
DF
str(DF)

# 불필요한 변수 삭제
DF <- subset(DF, select=c(-adress,-adressBystreet,-dateOfclosure,-startdateOfcessation, -duedateOfcessation,-dateOfreOpen,-zip))
DF
str(DF)

# 최초커피숍 찾기
# YearOfStart변수 범위를 구하면, 최초등록한 커피숍의 연도를 알수 있음
# rm=T 는 Na값을 제외하고 함수를 실행하기 위하여 추가
range(DF$yearOfStart,na.rm=T)

# subset을 이용하여 '운영중'인 관측치만 별도로 저장
DFFilter <- subset(DF, subset=(stateOfbusiness=="운영중"))
# 운영중인 가게의 년도
range(DFFilter$yearOfStart, na.rm=T)

subset(DFFilter,subset=(yearOfStart==1967))
# 해마다 오픈한 커피숍 개수를 찾기
table(DF$yearOfStart)

library("ggplot2")
qplot(yearOfStart,data=DF, geom="bar")

# table()함수에 두변수를 넣어 분할표를 만듦
# 연도별로 운영과 폐업 커피숍을 비교해봄
Freq <- table(DF$stateOfbusiness, DF$yearOfStart)
Freq

# 1997년도 이상 데이터만 저장
which(colnames(Freq)=="1997")

# 마지막 위치값을 알려줌
which.max(colnames(Freq))
Freq <- Freq[,c(30:47)]
Freq

# 비율을 확인 ( margin인자 값에 2를 넣으면 열의 비율로 계산 )
PFreq <- prop.table(Freq,margin=2)
PFreq

NewDF <- data.frame(colnames(Freq),Freq[1,],Freq[2,],PFreq[1,],PFreq[2,])
NewDF

# 행과 열의 이름을 정리
rownames(NewDF) <- NULL
colnames(NewDF) <- c("Time", "Open", "Close", "pOpen", "pclose")
NewDF

# 라인 그래프를 그림
ggplot(NewDF, aes(x=factor(Time),y=Close,group=1)) +
geom_line(colour="steelblue1", size=1)+
geom_point(colour="steelblue", size=3)+
geom_line(aes(y=Open),colour="tomato2", size=1)+
geom_point(aes(y=Open),colour="red",size=6)+
theme_bw()

# 빠르게 불러오기 위해 data.table패키지를 로드함
# 전국 커피숍 규모 파악하기
library("data.table")

DF <- fread("example_coffee.csv", header=T, stringsAsFactors=T, data.table=F)
DF
# 사업장 규모 변수만 별도 객체에 저장함
Size <- DF$sizeOfsite

# 자료의 특성을 파악
# 평균, 최소값과 최대값 그리고 결측치가 몇개인지 알려줌
summary(Size)
plot(Size)

# 아웃라이어를 삭제함
# 처리 후 결측치가 19에서 20으로 변함
Size[Size > 10000] <- NA
summary(Size)

# 0값과 NA값을 삭제
# 0값을 NA처리한 후 NA값 전체를 벡터에서 제거
Size[Size==0] <- NA

# Na값을 없애줌
Size <- Size[complete.cases(Size)]
summary(Size)

# 20단위로 계급을 만듬 
DegreeOfSize <- table(cut(Size, breaks=(0:72)*20))
DegreeOfSize

# 그래프를 그림
# 30~40사이즈가 가장많음, 대략 10평정도 규모의 커피숍이 가장 많은것으로 나타남
library("ggplot2")
library("ggthemes")
ggplot(data=DF,aes(x=sizeOfsite))+
geom_freqpoly(binwidth=10, size=1.2, colour="orange")+
scale_x_continuous(limits=c(0,300),breaks=seq(0,300,20))+
theme_wsj()

# 전국 인구조사 자료 정리하기
# stringAsFactors=F를 넣는 이유는 인구수 데이터에 ","가 있기때문에
# 해당 변수가 factor로 인식되기때문, 문자열로 인식하는게 편함
DF <- read.csv("example_population.csv", stringsAsFactors=F)
DF
str(DF)
# 자료 몇개만 살펴봄, head()함수 이용 (서울시, 종로구로 분리하고 숫자를 지움)
head(DF,5)

# 문자열 정리하기 위한 패키지
install.packages("stringr")
library("stringr")

# '(' 를 기준으로 앞 문자열만 사용
# '\\('은 정규식 표현으로 "(" 문자를 가리킴, 숫자는 몇개로 분리할것인지
# str_split_fixed()함수는 특정 문자열로 나눠지는 기능
temp <- str_split_fixed(DF[,1],"\\(",2)
head(temp,10)

# 공백을 기준으로 시, 구 를 나눔
NewCity <- str_split_fixed(temp[,1]," ",2)
head(NewCity,10)

# 변수 이름을 바꿈
colnames(NewCity) <- c("probvinces", "City")

# 작업한 변수를 합침
DF <- data.frame(NewCity, DF[,c(2:7)])
head(DF,3)

# City값중 빈곳을 NA로 바꿈
DF[DF==" "] <- NA
head(DF,10)

# NA가 있는 행은 삭제함
# NA가 있는 행은 시의 토탈값이였는데, 삭제하고 직접 R에서 컨트롤함
DF <- DF[complete.cases(DF),]
head(DF,10)

# 인구수 변수에 ","가 있어 문자열임. 계산하려면 수치형으로 바꿔야함
# 문자열 변수를 수치형 변수로 변경

# for문을 이용해 3번째 변수부터 8번째까지 중간에 ","이 들어있는 숫자를 삭제
# numeric으로 변환, 변수의 모든값은 function함수가 적용 적용되는 내용이 gsub()임
# gsub()은 첫 번째 인자를 두번째 인자로 변경
for(i in 3:8){ 
DF[,i] <- sapply(DF[,i], function(x) gsub(",","",x))
DF[,i] <- as.numeric(DF[,i])
}
str(DF)

# Province의 인구수만 불러옴
# tapply()는 그룹별로 평균이나 합을 보기위해 사용하는 함수

ProPopul <- tapply( DF$Population, DF$probvinces,sum)
ProPopul

# 세종시는 City값이 없어 NA정리될때 지워졌는데, Level값이 남아있어서 나옴
# probvinces변수를 factor로 다시 정의하면 값이 없는 Level은 삭제됨
DF[,1] <- factor(DF[,1])
ProPopul <- tapply(DF$Population, DF$probvinces,sum)
ProPopul

# ggplot2로 그래프를 그림
library("ggplot2")
library("ggthemes")
graph <- ggplot(DF, aes(x=probvinces, y=Population, fill=probvinces)) + 
geom_bar(stat="identity")
graph

# csv로 저장하기
write.csv(DF, "example_population_f.csv")
write



