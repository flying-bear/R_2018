library(tidyverse)
df1 <- read.csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/iclandic.aspirated.csv', stringsAsFactors = FALSE, sep = '')
df1 %>% 
  group_by(speaker) %>% 
  filter(aspiration == 'no') %>% 
  summarize(mean = mean(vowel.dur),
            ci_min = mean - 1.96*sd(vowel.dur)/sqrt(n()),
            ci_max = mean + 1.96*sd(vowel.dur)/sqrt(n()),
            range = ci_max - ci_min)



df2 <- read.csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/kuban_speech_rate.csv', stringsAsFactors = FALSE)
df2 %>% 
  filter(type == 'narrative') -> narrative
shapiro.test(narrative$mean)
t.test(narrative$mean, mu = 5.31)

binom.test(5, 75, 0.43)
