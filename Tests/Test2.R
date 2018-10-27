link = 'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/ewave.language.csv'
library(tidyverse)
df <- read_csv(link)
df %>% 
  filter(`Use of postpositions` == 'D',
         `Omission of StE prepositions` == 'A') %>% 
  select(Variety, World.Region)

link2 = 'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/zilo_class_experiment.csv'
df2 <- read_csv(link2)
df2 %>% 
  group_by(translation_en) %>% 
  count(vars=class) %>% 
  filter(n==5)

link3 = 'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/iclandic.aspirated.csv'
df3 <- read_tsv(link3)
df3 %>% 
  group_by(speaker, aspiration) %>% 
  summarise(mean_vow_dur = mean(vowel.dur),
            mean_voi_dur = mean(voicing.dur))

link4 = 'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/daghestanian_multilingualism.csv'
df4 <- read_csv(link4)
df4 %>% 
  filter(year_of_birth_dec < 1920) %>% 
  count(vars=residence) -> df4_sum
  

df4 %>% 
  filter(year_of_birth_dec < 1920,
         Russian == 1) %>%
  count(vars=residence) -> df4_rus

colnames(df4_rus)[colnames(df4_rus) == 'n'] <- 'rus'
full_join(df4_sum, df4_rus) -> df4_sum
rm(df4_rus)
df4_sum %>% 
  mutate(per = rus/n) %>% 
  arrange(desc(per))
