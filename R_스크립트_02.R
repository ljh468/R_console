# 데이터의 종류
# 변수
# - 범주형 데이터
	# 명목형변수 : 숫자가 아닌 문자로 예) 남,여
	# 순서형변수 : 문자지만 순서가 있음 예) A+, A, B+, B

# - 수치형 데이터
	# 이산형변수 : 이어져있지 않고, 셀수있음 예) 1명, 2명
	# 연속형변수 : 변수값이 연속적인 수치임 예) 175~176cm 

# 도수분포표 - 측정값을 카운트해 정리하는표

# 상대도수분포표 - 변수값이 변수값에서 어떤 비중을 차지하는지 나타내는것

# 누적상대도수 - 상대도수를 더해가며 누적된 값을 나타냄

# 분할표 - 남녀구분없이 전체인원에서 O형이 차지하는 비율을 알수있게함
# 분할표 - 목적에 따라 상대비율의 기준을 정해 사용할 수 있음

# 벡터 - R의 최소 데이터 단위
# 여러개의 벡터가 모여 하나의 데이터프레임을 이룸

# 벡터의 종류는 character(문자열), factor(순서형,명목형), integer(이산형), numeric(연속형)
# R은 정확히 알려주지않으면 더 큰 개념으로 정의 
a1 <- c(5,3,6,3,1)
a1
is(a1)

# 숫자뒤에 L을 붙이면 integer가 됨
a1 <- c(1L, 2L, 3L)
is(a1)
a1 <- as.integer(a1)

# 연속형 변수는 그냥 실수 값을 넣으면 됨
b <- c(1.23,6.63452, 4.34234)
b
is(b)

# 문자열 벡터 만들기, ""를 이용
a2 <- c("짬뽕", "짜장면", "짬뽕", "짬뽕", "짜장면")
a2

# 벡터는 여러개의 종류가 섞이지 않음, 한가지 데이터형식으로만 이루어짐
a3 <- c(7,3,7,5,2,"짜장면")
is(a3)

# 명목형 변수 만들기 
a2 <- as.factor(a2)
a2
is(a2) # Levels : 명목형변수의 종류를 여기에 표시함

a2 <- factor(a2, ordered=T)
a2  # :Levels를 보면 < 표시가됨, 순서를 나타내는것임

# 여러개의 벡터를 만들어 데이터프레임으로 합치기
# 데이터프레임을 만들려면 data.frame() 함수를 이용
a1 <- c(5,3,6,3,1)
a2 <- c("짬뽕", "짜장면", "짬뽕", "짬뽕", "짜장면")
a3 <- c(3.62,5.45,2.54,3.67,7.23)
DF <- data.frame(a1,a2,a3)
DF

# 벡터의 이름을 정해줌
DF <- data.frame(count=a1, food=a2, meanCount=a3)

# 외부 데이터 가져오기
DF <- read.csv("example_studentlist.csv")
is(DF)
is.vector(DF$height)

# 데이터프레임 구조 파악하기
str(DF)

# 데이터프레임 객체에 $를 붙이고 불러오고 싶은 변수의 이름을 적어주면 벡터를 찾음
DF$height
mean(DF$height)

# 다른객체에 저장가능
Height <- DF$height
Height

# []를 이용할수도 있음
DF[[7]]


# class()로 차이를 살펴봄
class(DF[7])		# dataframe
class(DF[[7]])		# numeric

# 위치 값으로 여러개 변수 선택하기
DF[c(6,7)]	# 여러개를 선택할때는 c()함수를 사용해야함

# 변수명으로 여러개 변수 선택하기
DF[c("bloodtype", "height")]

# 행렬 방식으로 변수 선택하기
DF[,7]
# 뒤를 생략하고 앞을 적으면 행이 선택됨
DF[2,]

# 앞, 뒤 모두적으면? 변수값 혹은 관측값이 나옴
DF[2,1]

# 행렬 방식이면서 변수명으로 선택하기
DF[,"height"]

##### 예제 5) 쉽게 변수 선택하기
DF <- read.csv("example_studentlist.csv")

# 검색목록에 데이터 프레임 올리기
attach(DF)
height
# DF를 붙이지 않으면 DF$를 붙여줘야함
detach(DF)
DF$height

##### 예제6) 조건으로 변수 선택하기 - 조건은 subset()함수
DF <- read.csv("example_studentlist.csv")
subset(DF, subset=(height> 170))

# select을 이용하면 관측치의 원하는 변수만 볼수있음
subset(DF, select=c(name,height), subset=(height>180))
subset(DF, select=c(-height, -weight))

# 변수명 바꾸기
DF <- read.csv("example_studentlist.csv")
colnames(DF)
colnames(DF) [6] <- "blood" # 6번째 컬럼 이름 바꿈

# 모든 변수 이름 바꾸기
OldList <- colnames(DF)
NewList <- c("na", "se", "ag", "gr","ab", "bl", "he", "we")
colnames(DF) <- NewList
DF

##### 예제 8) 새로운 변수 옆에 붙이기 (열을 새로 추가)
##### DF객체 옆에 BMI(체질량 지수) 를 붙여봄
DF <- read.csv("example_studentlist.csv")

# 벡터와 벡터를 계산하면 벡터요소가 서로 매치되어 계산됨
BMI <- DF$weight/DF$height^2
BMI

# 데이터프레임에 열로 붙이는 함수 cbind()
DF <- cbind(DF, BMI)
DF

##### 예제 9) 더 복잡한 새로운 변수 붙이기 ( 새로운 데이터프레임 추가 )  
##### 빼먹은 집합자료를 새로운 데이터프레임 객체로 불러옴
DF <- read.csv("example_studentlist.csv")
Omit <- read.csv("omit.csv")
Omit
# 관측치를 보면 기존 데이터프레임과 순서가 서로 다름
# 이럴때 name을 기준으로 값이 병합될 수 있도록 merge() 함수를 이용함
# merge("객체명", "추가할객체명", by="기준값)
DF <- merge(DF, Omit, by="name") 
DF

##### 예제10) 행으로 추가하기
##### 새로운 행을 추가 하기위해서는 추가할 데이터프레임이 있어야함
##### 같은이름의 열을 가지고 있어야함 
DF <- read.csv("example_studentlist.csv")
AddCol <- data.frame(name="이미리", sex="여자", age="24", grade="4", absence="무", bloodtype="A", height=175.2, weight=51)
AddCol

# 데이터프레임을 붙이려면 rbind()함수를 사용
DF <- rbind(DF, AddCol)
DF

##### 리스트는 어떠한 객체라도 받아들임
##### 예제 11) 모든 종류의 데이터 객체를 리스트 객체에 담기
DF <- read.csv("example_studentlist.csv")
a <- c(1:20) # 이산형
s <- c("파스타", "짬뽕", "순두부찌개", "요거트 아이스크림", "커피") # 문자열
L <- c(T,F,F,T,T,T) # 논리형

List <- list(DF, a,s,L )
List

# 리스트로 묶여 있을 뿐 서로 형태가 달라도 길이가 달라도 전혀 상관없이 리스트로 묶어 버림#
# 리스트에 이름 붙이기
List <- list(DataFrame=DF, Number=a, Character=s, Logic=L)
List

# 항목 삭제하기
List[1] <- NULL
List

# 이름으로 리스트 객체 항목 선택하기
List["Number"]
List["Character"]
List[1]
# class로 검색해보면 list객체로 나옴
class(List[1])
# Integer객체를 선택하고 싶다면 []를 한번 더 넣어야함
List[[1]]
class(List[[1]])

# 여러개 리스트 선택하기
List[c(2,3)]
List[c("Number", "Character")]

# 데이터프레임에서 $로 변수를 선택했던 것처럼 리스트에서도 사용가능함
List$Number
class(List$Number)
List$Character
class(List$Character)

# 개별 항목 이름 바꾸기
names(List) [2] <- "Num"
List[2]

# 모든 항목 이름 한번에 바꾸기
names(List) <- c("Num", "Cha", "Log")
List

##### 예제 12) 리스트 모든 항목에 동일한 함수 적용하기
DF <- read.csv("example_studentlist.csv")
# 데이터 프레임에서 몇개 변수를 리스트로 만들기
HeightBySex <- split(DF$height, DF$sex)
HeightBySex
class(HeightBySex) # 리스트 객체임

# 리스트 항목별 평균을 구함
mean(HeightBySex[[1]])
mean(HeightBySex[[2]])

# 한번에 동일한 함수 적용하기
sapply(HeightBySex,mean)
# 모든 항목의 표준편차 구하기
sapply(HeightBySex,sd)
# 모든 항목의 범위 구하기
sapply(HeightBySex,range)

# 명목형 변수로 도수 분포표 만들기
DF <- read.csv("example_studentlist.csv")

# 4구간으로 나눔
# cut( 나눌변수, breaks=나누고싶은 구간의 계수, labels=나눈 구간의 이름)
FactorOfHeight <- cut(DF$height, breaks=4)
FactorOfHeight

# 빈도수(도수)를 구함
FreqOfHeight <- table(FactorOfHeight)
FreqOfHeight

# 상대도수 구하기 prop.table()
FreqOfHeight <- rbind(FreqOfHeight,prop.table(FreqOfHeight))
FreqOfHeight

# 이름 바꾸기
rownames(FreqOfHeight) [2] <- "RelativeFreq"
FreqOfHeight

# 누적상대도수 구하기
CumuFreq <- cumsum(FreqOfHeight[2,])
CumuFreq
FreqOfHeight <- rbind(FreqOfHeight, CumuFreq)
FreqOfHeight

# 이름바꾸기
rownames(FreqOfHeight) <- c("도수", "상대도수", "누적도수")
FreqOfHeight

# 합 구하기
FreqOfHeight <- addmargins(FreqOfHeight, margin=2)
FreqOfHeight

# 분할표 만들기
# 두 변수의 조건을 만족하는 빈도수를 나타내는 표 - table()을 이용해 빈도수구함
DF <- read.csv("example_studentlist.csv")
CT <- table(DF$sex, DF$bloodtype)
CT

# 행과 열의 합을 구함 ( 상대도수의 합)
addmargins(CT)

# 상대도수 구하기
PropCT <- prop.table(CT)
PropCT
addmargins(PropCT)

# 남녀별로 상대도수를 구함
# margin 인자값에 1을 넣으면 행의 비율로 계산함
PropCT <- prop.table(CT,margin=1)
PropCT

# margin 1은 열의합, margin 2는 행의합
# 상대도수의 합
addmargins(PropCT, margin=2)

# 값이 없는것을 결측치라 부름 , 결측치와 관련된 함수는 complete.cases()와 na.omit()을 사용함
# complete.cases()함수는 NA값을 조사해 논리값으로 변환함
a <- c(1,2,3,4,NA,6,7,8,9,10)
a
complete.cases(a)

# 5번째 NA값이 FALSE임, 이를 이용해 NA값을 제거할 수 있음
a <- a[complete.cases(a)]
a
# NA 값을 완전히 제거하는 함수
a <- na.omit(a)
a




