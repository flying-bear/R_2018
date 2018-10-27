link1 <-  'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/data.japanese.vocal.tract.length.csv'
df1 <- read.csv(link1, stringsAsFactors = FALSE)


df1 %>%
  gather(., 'vowel_l', 'length', 4:8) %>% 
  mutate('vowel' = substring(vowel_l, 1, 1)) %>% 
  ggplot(aes(ID, length, label = vowel))+
  geom_text()+
  labs(x = 'speakers', y = 'length of the vocal tract', 
       caption = 'data from [Hatano et. al 2012]')

df1 %>%
  gather(., 'vowel_l', 'length', 4:8) %>% 
  mutate('vowel' = substring(vowel_l, 1, 1)) %>% 
  ggplot(aes(vowel, length))+
  geom_boxplot()+
  labs(x = 'vowel', y = 'length of the vocal tract', 
       caption = 'data from [Hatano et. al 2012]')+
  geom_hline(aes(yintercept = mean(length)), linetype = 2)

df1 %>%
  gather(., 'vowel_l', 'length_of_vocal_tract', 4:8) %>% 
  mutate('vowel' = substring(vowel_l, 1, 1)) -> df1_long 
  
df1_long %>%  
  ggplot(aes(length_of_vocal_tract, fill = vowel))+
  geom_histogram(data = df1_long[, -7],
                 aes(length_of_vocal_tract),
                 fill = 'grey', bins = 8)+
  geom_histogram(bins = 8, show.legend = FALSE)+
  facet_wrap(~vowel)+
  labs(x = 'lenth of vocal tract', y = 'count', 
       caption = 'data from [Hatano et. al 2012]')

