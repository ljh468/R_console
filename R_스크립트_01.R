print("Hello World")
9*8*7*6*5*4*3*2*1
factorial(9)

# 두개의 인자가 필요한 함수 rep() times만큼 반복해서 출력
rep(x="배고파", times=5)

plot(10,10)
plot(c(5,7), c(20,30))
plot(runif(100),runif(100))

#R은 변수란 말 대신 객체란 단어를 사용함
Object1 <- 1
Object2 <- 2
Object1
Object2
1+2
Object1 <- "문자열"
Object2 <- "데이터"

# paste()함수는 여러객체를 합쳐서 보여주는 함수
paste(Object1,Object2)

# 논리형의 Boolean데이터를 넣을수도 있음
Object1 <- TRUE
Object2 <- FALSE
Object1
Object2

# R의 최소단위는 벡터 ( R에는 스칼라는 없고 벡터가 최소단위임)
# 정수(1), 실수(5.8271), 문자('A'), 문자열("Hello")을 스칼라라고 부르고
# 말그대로 가장 작은 데이터임, {4,5,6,3,2,1} 과 같이 스칼라가 모인것을 벡터라고 부름

# 객체에 또다른 객체를 넣기
Object2 <- 2
Object1 <- Object2 
Object1

# R에는 포인트 개념이 없음
Object1 <- 1
Object2 <- 2
Object1 <- Object2
# 주소개념이 아니고 값이 들어가는것임
Object2 <- 100
Object1

# 객체에 함수 넣기 (sum은 모두 더한값)
Object1 <- sum(1,8,4,5,9)
Object1

# R은 통계를 위한 프로그램 언어이고, 엄청 큰 데이터를 다뤄야 하기때문에
# 작은 단위까지 일일이 신경 쓰지 안게 하기 위함
# 벡터를 다루는 함수는 c() , c()함수 인자안에 벡터로 묶을 데이터를 넣어주면됨
a <- c(1,3,5,6,9)
a

# 벡터를 확인하기 위해 is.vector()함수를 사용
# 단일 값을 넣어도 벡터임
a <- 1
is.vector(a)
a <- c(1,2,5)
is.vector(a)

# 객체에 여러개 문자열을 넣음
a <- c("첫번째", "두번째", "배고파")
a

# 벡터는 한가지 데이터 형식만 가짐
# 3번째까지 정수이지만 마지막은 문자열임, 모든값은 문자열로 바꿔짐
a <- c(1,2,5,"점심")

# 벡터를 추가, 삭제, 수정하기
Object <- c(1,3,8,9)
Object

# 맨끝에 값을 추가 하고 싶다면?
Object <- c(Object,11)
Object

# 앞에 넣고 싶다면?
Object <- c(0,Object)
Object

# 중간에 넣고 싶다면? after 이후에
Object <- append(Object, 99, after=2)
Object

# 중간에 값을 빼고 싶다면? 두번째값이 사라짐
Object <- Object[-2]
Object

# 맨 끝 값을 삭제하고 싶다면?
Object <- Object[-length(Object)]
Object

# 특정 위치의 값을 바꾸고 싶다면?
Object[3] <- 9
Object

# 5라는 값을 모두 100을 바꾸고 싶다면?
Object <- c(1,2,3,4,5,6,7,8,9,5,6,7,8,9)
Object[Object ==5] <- 100
Object

# 자신이 만든 모든 변수를 보고싶으면 ls()
ls()
ls.str()

# 객체를 지우고 싶다면 rm(객체명, 객체명, 객체명)
rm(Object,a)

# 모든 객체를 지우고 싶으면?
rm(list=ls())


# 필수 설치패키지
install.packages("rgl")
install.packages("ggplot2")
install.packages("ggthemes")
install.packages("data.table")
install.packages("devtools")
install.packages("dplyr")
install.packages("plyr")
install.packages("reshape2")
install.packages("scales")
install.packages("stringr")

# 패키지 설치내역 확인
library()
installed.packages() 



# 3dplot을 구현해주는 패키지
install.packages("rgl")
library("rgl")
example(plot3d)

# Excel 파일 읽어오기
install.packages("readxl")
library("readxl")

# 도수분포표를 만들기 위한 데이터셋
install.packages("hflights")
library("hflights")

# ggplot2(그래프 그리기) 이용하기위해 사용
install.packages("ggplot2")
library("ggplot2")

# ggthemes (테마) 를 이용하기위함
install.packages("ggthemes") 
library("ggthemes")

# 데이터를 빠르게 가져오기위해사용
install.packages("data.table")
library("data.table")

# 문자열을 특정문자를 기분으로 나누기 위해 사용
install.packages("stringr")
library("stringr")


## R에서 외부데이터를 읽어 들이는 방법

# csv 포맷 읽어 들이기
# dataframe 객체에 담김
List <- read.csv("example_studentlist.csv")
List

# txt 포맷을 다양한 방법으로 읽어 들이기
# txt는 tab으로 값을 구분해서 만듦
List <- read.table("studentlist.txt")
List

# read.table()은 header인자의 값이 FALSE로 되어있음
# 파일에 변수열 이름이 있다면 header = TRUE 인자를 반드시 입력해야함
List <- read.table("studentlist.txt", header = TRUE)

# ; 로 구분되어 있다면 sep=";"
List <- read.table("studentlist2.txt", header = TRUE, sep=";")
List

## 엑셀파일을 읽고 싶다면? readxl 이 필요함
DF <- read_excel(path="studentlist.xlsx",sheet="Sheet1",col_names=TRUE )
DF





