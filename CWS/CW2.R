install.packages('tidyverse')
library(tidyverse)
as.tibble(iris)
data_frame(numbers = 1:10, letters = letters[1:10])
df <- read.csv('https://goo.gl/v7nvho') # as factors
as.tibble(df)
df <- read_csv('https://goo.gl/v7nvho')
df2 <- read_tsv('https://goo.gl/33r2ut') # bad link((
remove(df2) #rm(df)

#pipe
sort(sqrt(abs(sin((1:20)^2))), decreasing = FALSE) # unreadable
(1:20)^2 %>%  #CTRL+SHIFT+M
  sin() %>%
  abs() %>% 
  sqrt() %>% 
  sort(., decreasing=TRUE)

#dplyr
df %>% 
  filter(Age > 16) # shows only those over 16 years old

df %>% 
  filter(Age > 16, # shows only those over 16 years old
         Gender == 'male') # shows only male participants 
  
df %>% 
  slice(c(4, 3, 9)) ->
  df2 # puts given vector of lines into df2
rm(df2)

df %>% 
  select(Age, City, Gender) # shows given columns
df %>% 
  select(Age:WordType) # shows given columns (':' works in dplyr only)


df %>% 
  filter(Age > 20,
         Gender == 'male') %>% 
  select(Age:Stimulus)

df %>% 
  select(Age:Stimulus) %>% 
  mutate(rate = Age/GivenScore, # add column
         rate2 = rate*rate) %>% 
  mutate(rate = round(rate)) # change column
  
df %>% 
  select(Age:Stimulus) %>% 
  group_by(Education) %>% # creates two subgroups
  summarise(mean_age = mean(Age),
            age_sd = sd(Age)) # shows data on subgroups
            
df %>% 
  mutate(older = Age > 25) %>% 
  group_by(Gender, older) %>% 
  summarize(mean_age = mean(Age),
            age_sd = sd(Age))

df %>% 
  group_by(Gender, older = Age > 25) %>% # creates four subgroups
  summarize(mean_age = mean(Age),
            age_sd = sd(Age)) %>% 
  arrange(desc(mean_age)) # sorts groups by mean_age in decreasing order desc()


#join in dplyr
languages <- data_frame(
  languages = c('Selkup', 'French', 'Chukchi', 'Kashubian'),
  countries = c('Russia', 'France', 'Russia', 'Poland'),
  iso = c('sel', 'fra', 'ckt', 'pol')
  )

country_population <- data_frame(
  countries = c('Russia', 'Poland', 'Finland'),
  population_mln = c(143, 18, 5)
  )

inner_join(languages, country_population) # only those occuring in both
left_join(languages, country_population) # only those occuring in the left (those not given in the right are written as NA)
right_join(languages, country_population) # only those occuring in the right (those not given in the left are written as NA))
anti_join(languages, country_population) # those not occuring in the right but occuring in the left (for example used to delete stopwords)
full_join(languages, country_population) # join everything

#tidyr
df.short <- data.frame(
  consonant = c('stops', 'frictives', 'affricates', 'nasals'),
  initial = c(123, 87, 73, 7),
  intervocal = c(57, 77, 82, 78),
  final = c(30, 69, 12, 104)
  )

df.short %>% 
  gather(key = position, value = value, initial:final) ->
  df.long

df.long %>% 
  spread(key = position, value = value)