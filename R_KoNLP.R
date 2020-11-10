.libPaths()
setwd()
getwd()

Sys.setenv(JAVA_HOME='C:/Java/jdk1.8.0_191')

install.packages("multilinguer")
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
library(multilinguer)
library(rJava)
library(memoise)
library(KoNLP)

remotes::install_github('haven-jeon/KoNLP',upgrade = "never", INSTALL_opts=c("--no-multiarch"))

install.packages("dplyr")
library(dplyr)
install.packages(c('stringr','hash','tau','Sejong','RSQLite','devtools'), type="binary")

install.packages("remotes")
install.packages("devtools")
library("devtools")
devtools::install_github('haven-jeon/KoNLP',upgrade = "naver", INSTALL_opts=c("--no-multiarch"))