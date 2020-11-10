# 기술 통계
# 데이터를 수학으로 기술하는것
# 데이터를 수치로 특징을 말하는 이유는 정확하기 때문

# 평균(mean)
# 모평균은 방대한값(추론을 통해 알아야함)
# 표본평균은 기술통계에서 말하는값 (보통 평균이라고 말하는값)

# 아웃라이어
# 평균을 크게 변하게 하는값을 아웃라이어라고 함
# 왜 발생했는지, 어떤 영향을 미치는지 확인해야함

# 사분위범위 IQR (25%, 50%, 75%, 100%)
# IQR과 중앙값 그리고 아웃라이어를 표시하는 도형은 Boxplot임

# 산포도 : 얼마나 퍼져있나?
# 분산과 표준편차
# 산포도는 최저, 최고, 표준편차를 알려줌

# 표준편차는 각각제곱해서 합산 그리고 루트를 씌움
# 이를 갯수대로 나누면 분산
# 분산은 평균에서 값들이 얼마나 떨어져 있는지 알려주는 값

# 표준화
# 평균을 0으로 이동하여 0을 기준으로 데이터를 위치시킴
# 각각 값을 표준편차로 나누면 표준편차가 1이됨
# 평균을 0으로 표준편차를 1로 만드는것을 표준화라고 함
# 표준화 된 점수를 표준점수라 부름

# 변동계수
# 평균과 표준편차가 서로다른 두 데이터를 비교하기위해 만들어짐
# 얼마나 다른지 비율만 보는것임
# 표준편차/평균 (얼마나 넓게 분포되어있는지 알수있음)

# 공분산
# 변수가 두개이상인 다변량일때 분산을 공분산이라고함
# 온도/습도 그래프에서 점들이 직선에 가까운 형태를 띨때 긴밀한관계임

# 상관계수
# -1부터 1까지의 값을 가지는데 0에 가까울수록 두변수는 관계가 없음
# 1혹은 -1에 가까울수록 두변수는 관계가 긴밀함

# 기술통계 값 구하기
library("data.table")
DF <- fread("example_studentlist.csv", data.table=F)
DF

# DF가 데이터프레인에 올라와있는지 확인
search(DF)
# 있으면 detach(DF)로 지우고
# 없으면 새로올림
attach(DF)

# NA값은 지우고 평균을 냄
mean(height, na.rm=T)

# 중앙값 구하기
median(height, na.rm=T)

# 범위 구하기
range(height, na.rm=T)

# 사분위 구하기
quantile(height, na.rm=T)

# IQR구하기 ( 사분위에서 Q1과 Q3의 범위를 나타냄)
IQR(height, na.rm=T)

# 평균, 중앙값, Q1, Q3 한번에 보려면?
summary(height, na.rm=T)

# BoxPlot도형으로 변수 특성 보기 -NA값은 제거하고 보여줌
boxplot(height)

# 상관계수 다루기 (두변수만 넣으면 상관계수를 바로 구해줌)
cor(height, weight)
cor.test(height, weight)

# 세개의 변수
cor(DF[,c(3,7,8)])

# 여러 변수를 다루는 함수에서 결측치 다루기
cor(height, weight, use="complete.obs")
DF2 <- DF
DF2[2,7] <- NA
DF2[4,8] <- NA
DF2
detach(DF2)
attach(DF2)
cor(height,weight) # NA값 나옴

# use="complete.obs"는 관측치를 빼지않고 NA가 포함된 벡터만 빼고 계산함
cor(height, weight, use="complete.obs")
cor(height, weight, use="everything")
cor(height, weight, use="all.obs") # 결측치가 있으면 계산하지않음

# 분산과 공분산 구하기
var(height, na.rm=T)

# var()는 두개변수를 넣을수 있음
var(height, weight, na.rm=T)
# 세개이상 변수를 넣으면 매트릭스로 서로 공분산 값을 구해줌
var(DF[,c(3,7,8)], na.rm=T)

# 표준편차 구하기
sd(height, na.rm=T)

# 표준화 하기 (매트릭스로 반환)
scale(height)

# 변동계수 구하기 (얼마나 넓게 분포하는지 알수 있음)
# 변동계수는 표준편차를 평균으로 나눔
sd(height)/mean(height)
sd(weight)/mean(weight) # 몸무게가 더많이 분산되어 있다는것을 알수있음



