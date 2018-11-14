library(tidyverse)
df1 <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/coates_leech.csv')

df1 %>% 
  group_by(var, word, meaning) %>% 
  summarize(n = n()) %>% 
  spread(key = meaning, value = n) %>%
  mutate(rel = round(root/epistemic, digits = 2)) -> df1.1

df1.1 %>% 
  select(-epistemic, -root) %>% 
  spread(key = var, value = rel) -> df1.2

PHOIBLE <- c(2155, 419)
WALS <-  c(567, 97)

binom.test(419, 2155, 97/567)

df4 <- read_tsv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/slavic_case_alternation.csv')
df4 %>% 
  filter(lang == 'rus') -> df4_rus
df4 %>% 
  filter(lang == 'pol') -> df4_pol
rus <- table(df4_rus)
pol <- table(df4_pol)
chisq.test(rus)
fisher.test(pol) #??
df5 <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/bnc_pron.csv')
cor(df5$P1, df5$P2)
