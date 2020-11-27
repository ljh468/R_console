# 회귀분석
- 평균으로 돌아가려는 현상 ( 값이 평균에서 벗어나지 않음)
- 회귀분석은 변수간의 관계에 대해서 마하기 위해 필요함
- 상관계수는 관계의 긴밀함을 수치적으로 얘기하지만, 회귀는 변수의 변화에 따른 다른 변수의 값을 파악함
- 회귀분석은 독립변수가 종속변수에 어떤 영향을 미치는지 알아보는 방법
EX) 50 100 150 200 이면 250 일 것이다.
- R에서는 lm()함수를 실행하면 (원래는 미분으로 적합한 함수를 찾아야함)

# 단순 선형 회귀모델 이해하기
- 모든점을 지나지 않지만 최대한 모든 점의 근처를 지나고 있음
- 직선의 함수식 Y = a + bX임
- 모든점에 적합한 선(회귀모델)을 수학적으로 찾는 것은 a와 b를 구하는것임

# R에서 회귀모델 구하기
lm(mpg~hp, data=mtcars)

# 회귀모델은 포본데이터를 통해 만듦
- 모집단은 너무 크고 모두 조사할 수 없는 경우가 대부분이라 표본을 통해 모집단을 알아내는 것임
- 회귀모델을 통해 모집단의 특성을 말할 수 있고 두 변수간의 관계를 설명

# 잔차는 회귀모델에서 데이터가 떨어진 값임
DF <- data.frame(Work_hour=1:7)

# 기본 회귀모델 실습
DF <- data.frame(Work_hour=1:7, Total_pay=seq(10000, 70000, by=10000))
plot(Total_pay~Work_hour, data=DF, pch=20, col=“red”)
grid()

# 절편과 기울기 구하기
LR <- lm(Total_pay ~ Work_hour, data=DF)
LR
- 사용방법은 lm(종속변수 ~ 독립변수, 데이터임). ‘종속변수 ~ 독립변수’를 formula인자라 부르고 데이터를 데이터인자라 부름
- 절편(Intercept)값은 ?5.5e-12이고 Work_hour가 기울기임

# lm 속성 사례보기
mode(LR)
- lm()함수로 반환하는 값은 리스트임
# 절편과 기울기 라인을 그림
- abline()함수로 회귀모델을 그림
abline(LR, col=“blue”, lwd=2)

# 안타와 홈런 변수를 활용한 회귀분석
DF <- read.csv(“exmple_kbo2015.csv”)
str(DF)
- 안타와 홈런 두변수간의 상관관계에 대해서 알아봄
- 안타는 H, 홈런은 HR
DF$H
DF$HR
# 두변수의 상관관계를 구함
cor(DF$H, DF$HR)
# 두 변수간의 산점도를 그림
plot(HR~H, data=DF, pch=20, col=“grey”, cex=1.5)
- 산점도를 H에 따른 HR이 서로 양에 비례한다는 것을 알 수 있음
# 회귀모델 그림
Lm <- lm(HR~H, data=DF)
Lm
abline(Lm, lwd=2, col=“red”)
- 회귀분석은 기울기가 의미가 있음

# mtcars 데이터셋으로 회귀분석하기 (R 의 내장 데이터셋)
mtcars
str(mtcars)
# hp(마력수)를 독립변수로 mpg(연비)를 종속변수로 두고 회귀분석을함
cor(mtcars$hp, mtcars$mpg)
plot(mpg~hp, data=mtcars)
Lm <- lm(mpg~hp, data=mtcars)
abline(Lm, col="red")
Lm

# 결정계수
# 회귀모델을 검증하기 가장 쉬운방법은 결정계수를 살펴보는것임
# R2가 클수록 회귀모델이 모집단의 데이터에 적합했다고 함
# R2는 상관계수를 제곱해서 얻은값
# 회귀모델이 적합하려면 상관계수가 높아야함

# R에서 결정계수 보기
# R에서 summary()함수로 lm객체를 요약해서 보면 알수있음
options(scipen=999) #scientific notation이 나오지않도록함
summary(Lm)
# Adjusted R-squard "수정된 결정계수"
# 독립변수가 많아지면 자연스럽게 커지는 현상을 조절한 계수

# 선형 회귀모델 가설검증
# R에서 summary()함수로 lm객체를 요약해서 보면 알수있음
option(scipen=999) # scientific notation이 나오지않도록함
summary(Lm)
# p-value가 p값임 (0.05보다 작으면 b1이 0일 가능성이 낮아지면서 회귀모델이 적합하다고 통계적으로 말할수 있음
# 신뢰구간을 알고싶다면
confint(Lm)

# 잔차 관련그래프를 그려 회귀적합성 검증하기
# 잔차는 실제 족속변수 값과 회귀모델에 의해 추정되는 종속변수 값의 차이임
# 잔차의 평균이 0에 가까워지며 잔차들이 정규분포를 따를 때 "회귀적합성이 타당하다"고 할수 있음
# 잔차 관련 그래프 그리기
par(mfrow=c(2,2)) #  4개의 그래프를 한번에 보기
plot(Lm)

# 잔차 그래프를 그려서 검증하기
DF <- read.csv("example_residuals_checking.csv")
head(DF, 3)

# x1, y1을 한쌍으로, x2, y2를 한쌍으로 분석해서 서로 비교
# 첫번째 회귀계수를 구함
Lm.res1 <- lm(y1~x1, data=DF)
Lm.res1
# 두번째 회귀계수를 구함
Lm.res2 <- lm(y2~x2, data=DF)
Lm.res2
# -> 추정된 회귀모델은 같다고 나옴
# 두그래프를 그림
par(mfrow=c(2, 1)
plot(y1~x1, DF, pch=20, cex=1.5, ylim=c(0,30), main="Data1")
plot(y2~x2, DF, pch=20, cex=1.5, ylim=c(0,30), main="Data2")
# 시각화해보니 산포의 차이가 있음, 실제로는 차이가 있음, 반드시 회귀모델을 만든후 검증해야함
par(mfrow=c(2,1))
plot(y1~x1, DF, pch=20, cex=1.5, ylim=c(0, 30), main="Data1")
abline(Lm.res1, col="blue", lwd=2)
plot(y2~x2, DF, pch=20, cex=1.5, ylim=c(0, 30), main="Data2")
abline(Lm.res2, col="blue", lwd=2)
# -> 수학적으로 회귀모델이 적합할 수 있어도 왠지 억지로 끼워 맞춘듯한 느낌
# 두그래프의 산점도는 차이가 있음
# 결정계수와 F통계량을 확인함
options(scipen=999)
summary(Lm.res1)
summary(Lm.res2)
# -> 둘 다 결정계수 F통계량은 적합
# 잔차 관련 그래프를 그림
par(mfrow=c(2,2))
plot(Lm.res1)
plot(Lm.res2)
# -> 역시 첫번째데이터는 일정하게 분포 하지않고, U자모양 패턴을 보임, 패턴이 있는 그래프는 적합하지않음

# 다중선형회귀분석
# 보통 사회현상에서 종족변수에 영향을 미치는 독립변수가 1개인 경우는 거의없음
# 종속변수 : 키 , 독립변수 : 몸무게, 성별, 발사이즈
# 키를 설명하기 위한 독립변수가 여러개인 경우 " 다중선형회귀모델" 이라고 함
# 독립변수가 2개이상이면 2D그래프로 표현할 수 없음
# 독립변수가 3개면 4차원그래프가 필요한데 4차원은 없음, 수치를 통한 해석이 유용
# 단순선형회귀분석에서 b0, b1을 구했던것처럼 다중선형은 b0, b1, b2, b3, b4 ... 을 구하는것이 목적임

# R에서는 lm()함수에 변수만 추가하면됨
lm(HR~R+H+AO)
# 마력(hp), 실린더(cyl), 차체무게(wt)가 영향을 얼마나 주는지 다중선형회귀분석을 사용
DF <- mtcars
str(DF)
# 독립변수를 추가함
Lm <- lm(hp~cyl+wt, data=DF)
Lm
# -> b0, b1, b2변수 각각의 회귀계수가 나옴
# 검증
summary(Lm)
# 각 회귀계수마다 0일 가능성을 나타내는 확률값을 살펴봐야함
# 0일 가능성을 보여주는데 Pr(>|t|) 값이 확률을 알려줌
# 0.05보다 작은 값이 나와야함
# wt는 0.9가 나왔으므고 이변수를 제거하는것이 좋음

# 추정치 구하기
# 회귀모델이 구해지면 이 모델을 통해 값을 추정할 수 있음
# 추정하는 방법은 predict()함수를 사용하는 것임
# 야구 데이터로 추정하기 (팀별 성적 데이터)
DF <- read.csv("example_kbo2015.csv")
head(DF, 3)
str(DF)

# 홈런에 대한 루타를 회귀분석해 만들어봄
Lm <- lm(HR~TB, data=DF)
Lm
# -> TB회귀계수를 보니 루타가 10개이면 약1.5개정도 홈런이 발생함
# 검증
summary(Lm)
# -> R2도 0.9, 회귀계수도 0일 가능성 없음
# predict는 x값을 회귀모델에 넣어 추정치를 구함
b <- predict(Lm)
b
# y값과 추정치 값을 비교해봄
DF$HR[1]
b[1]
# -> 값이 크게 차이나지 않음, 회귀모델로 적합하기 때문
# 데이터 프레임에 넣어 비교
Com <- data.frame(team=DF$team, HR=DF$HR, fittedHR=b)
Com
# 새로운 데이터를 만듦
# 루타가 1600일 때 홈런이 몇 개일지 추정해봄
NewTeam <- data.frame(TB=1600)
# 새로운 데이터를 만들때 데이터프레임으로 만들어야함
# 회귀모델을 만들때 TB변수를 사용했기 때문에 데이터프레임도 TB변수를 사용해야함
# 예측값을 구함
predict(Lm, newdata=NewsTeam)
# -> 1600루타 값을 넣었더니 121개 홈런이라고 알려줌












