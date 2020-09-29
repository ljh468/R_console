데이터의 종류
변수
- 범주형 데이터
	ㅇ 명목형변수 : 숫자가 아닌 문자로 예) 남,여
	ㅇ 순서형변수 : 문자지만 순서가 있음 예) A+, A, B+, B
- 수치형 데이터
	ㅇ 이산형변수 : 이어져있지 않고, 셀수있음 예) 1명, 2명
	ㅇ 연속형변수 : 변수값이 연속적인 수치임 예) 175~176cm 
// 필수 설치패키지
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

install.packages("rgl")  // 3dplot을 구현해주는 패키지
library("rgl")
intaslled.packages()  // 패키지 설치내역 확인

install.packages("readxl") // Excel 파일 읽어오기
library("readxl")

install.packages("hflights") // 도수분포표를 만들기 위한 데이터셋
library("hflights")

install.packages("ggplot2")  // ggplot2(그래프 그리기) 이용하기위해 사용
library("ggplot2")

install.packages("ggthemes") // ggthemes (테마) 를 이용하기위함
library("ggthemes")

install.packages("data.table")  // 데이터를 빠르게 가져오기위해사용
library("data.table")

install.packages("stringr") // 문자열을 특정문자를 기분으로 나누기 위해 사용
library("stringr")