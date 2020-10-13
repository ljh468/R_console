# 6장 순열과 조합을 구하는 (경우의 수) 구하기
# Gtools 패키지를 이용하여 계산
install.packages("gtools")
library("gtools")
name <- c("A","B","C")

# 3개중에 2개를 name에서 구함 (순열)
permutations(3,2,name)
# 3개중에 2개를 name에서 구함 (중복순열)
permutations(3,2,name,repeats.allowed=T)
# 중복을 허용하지 않는 순열의 경우의수, 행의 수를 세면 됨
nrow(permutations(3,2,repeats.allowed=T))
# 순서 상관없는 조합에 대해 알아봄 (조합)
combinations(3,2,name)
# 중복을 허락하는 중복조합을 원한다면 (중복조합)
combinations(3,2,name,repeats.allowed=T)

# 1000번중에 9번 할 확률은 0.03
dbinom(9, 10000, 0.0009)

# 시험관 아기를 해주는 병원의 성공확률이 20% 5번째에 성공할 확률은?
a <- dgeom(1:10, 0.2)
a
# 6.5%라는 것 , 5번을 시행하는 동안의 성공확률을 누적시키면?
sum(a[1:5])
