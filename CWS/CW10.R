library(tidyverse)
sonet <- read_csv('https://raw.githubusercontent.com/agricolamz/2017_HSE_SPb_R_introduction/master/data/57_sonet.csv')
zilo_classes <- read_csv('https://raw.githubusercontent.com/agricolamz/2017_HSE_SPb_R_introduction/master/data/zilo_classes.csv')

##full agreement percent
install.packages('irr')
library(irr)
agree(zilo_classes[,4:19])

##cohen's kappa (2 rator agreement on a cathegorical variable)
zc2 <- zilo_classes[, c(4, 14)]
table(zc2)
p_o <- (54+44)/(54+44+2+6)
p_e <-  ((54+6)*(54+2)+(44+6)*(44+2))/(54+44+2+6)^2
kappa <- (p_o-p_e)/(1-p_e)
kappa2(zc2)
# k < 0 poor agreement
# 0 < k < 0.2 slight agreement
# 0.21 < k < 0.4 fair agreement
# 0.41 < k < 0.6 moderate agreement
# 0.61 < k < 0.8 substantial agreement
# 0.81 < k < 1 almost perfect agreement

## Kendall's correlation (Kendall tau rank correlation coefficient (one may use Spearman as well) - 2 rator agreement on a numeric variable)
C <- c(10, 10, 8, 8, 6, 6, 4, 4, 2, 2, 0, 0)
D <- c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
n <- 12

2*sum(C-D)/(n*(n-1))

ranker_1 <- 1:12 # 1:12 * 24 - the same result
ranker_2 <- c(2, 1, 4, 3, 6, 5, 8, 7, 10, 9, 12, 11)

as.tibble(data.frame(ranker_1 = ranker_1, ranker_2 = ranker_2, C = C, D = D))

cor(ranker_1, ranker_2, method = 'kendall')
View(cor(sonet[,-1], method = 'kendall'))

## Fleiss's kappa (multiple interrator agreement on a cathegorical variable)
kappam.fleiss(zilo_classes[,4:19])

## Intra-class Correlation Coeffitient (ICC - (multiple interrator agreement on a numeric variable)
icc(sonet[,-1], model = 'oneway', type = 'agreement')
