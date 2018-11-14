library(tidyverse)
df1 <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/bnc_pron.csv')
fit1.1 <- lm(P1~P2, data = df1)
fit1.2 <- lm(P1~P2+Reg, data = df1)
AIC(fit1.1, fit1.2)
predict(fit1.1, newdata = data.frame(P2 = 0.5, Reg = 'Spok'))

df2 <- read_tsv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/language_diversity.csv')

df2 %>% 
  ggplot(aes(Langs, MGS))+
  geom_point()

df3 <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/orientation.csv')
fit3 <- lm(perceived.as.homo~vowel.duration.ms+average.f0.Hz+f0.range.Hz+s.duration.ms+age, data = df3)
fit3_best <- step(fit3, direction = 'both')
summary(fit3_best)
