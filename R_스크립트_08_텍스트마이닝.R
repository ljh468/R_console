# 텍스트 마이닝 ( KoNLP를 사용하려면, rJAVA, memoise패키지가 설치되야함)
install.packages("rJava")
install.packages("memoise")

# 현재 버젼이 바뀌면서 KoNLP 설치가 안됨
install.packages("KoNLP")
library(dplyr)

# 다른방법으로 KoNLP 설치
install.packages("multilinguer")

# 의존성 패키지 설치
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")

install.packages("remotes")

#github 버젼 설치 (KoNLP)
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(multilinguer)
library(KoNLP)

# 형태소 사전 설치
install.packages("devtools")
library(devtools)
devtools::install_github('haven-jeon/NIADic/NIADic', build_vignettes = FALSE)

# Java 홈 디렉토리 설정
Sys.setenv(JAVA_HOME='c:/Java/jdk1.8.0_191')

# 세종 한글 사전 로딩
buildDictionary(ext_dic = "woorimalsam")

# 사전 설정하기
useNIADic()

txt <- readLines("hiphop.txt")

head(txt)

# 특수문자 제거하기
library(stringr)
txt <- str_replace_all(txt, "\\W", " ")

# 가장 많이 사용된 단어 알아보기
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))

# 데이터 프레임으로 변환
library(dplyr)
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

# 변수명 수정
df_word <- rename(df_word, word = Varl, freq = Freq)

# 자주 사용된 단어 빈도표 만들기 ( 가장 많이 사용된 20개 단어를 나타낸 단어 빈도표를 만듦)
df_word <- filter(df_word, nchar(word) >= 2)

# 빈도순으로 정렬후 상위 20개 단어를 추출함
top_20 <- df_word %>%
arrange(desc(freq)) %>%
head(20)
top_20

# 워드 클라우드 만들기 (빈도를 구름 모양으로 표현한 그래프)
install.packages(wordcloud)
libarary(RColorBrewer)

# 단어 색상 목록 만들기
pal <- brewer.pal(8, "Dark2")

# 난수 고정하기
# wordcloud()함수를 실행할때마다 난수를 이용해 매번 다른 모양의 워드 클라우드를 만들어냄
# 단어가 많이 사용 된 단어일수록 크고 가운데 배치됨
set.seed(1234)

wordcluud(words = df_word$word$word, 
freq = df_word$freq,
min.freq =2, 
max.words = 200,
randome.order = F,
rot.per = .1, 
scale = c(4, 0.3), 
colers=pal)


pal <- brewer.pal(9, "Blues")[5:9]
sert.seed(1234)

wordcloud(words = df_word$word, 
freq = df_word$freq,
min.freq = 2, 
max.words = 200, 
rendom.order = F, 
rot.per = .1, 
scale = c(4, 0.3),
colors = pal)

# 국정원 트윗 테스트 마이닝
library(KoNLP)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
twitter <- read.csv("twitter.csv", header = T, stringsAsFactors = F, fileEncoding = "UTF-8")