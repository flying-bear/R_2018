library(tidyr)
link_df <-  'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/Ustya_data.tsv' ## df used as the example in class

quartet <- subset(read.csv("https://raw.githubusercontent.com/flying-bear/R_2018/master/Anscombe%E2%80%99s%20quartet.csv", stringsAsFactors = FALSE), select = -id)
quartet %>% 
  group_by(dataset) %>% 
  summarize(mean_x = mean(x),
            mean_y = mean(y),
            sd_x = sd(x),
            sd_y = sd(y),
            cor = cor(x,y),
            n =n())

datasaurus <- read.csv('https://raw.githubusercontent.com/flying-bear/R_2018/master/DatasaurusDozen.tsv', sep = '\t', stringsAsFactors = FALSE)

datasaurus %>% 
  group_by(dataset) %>% 
  summarize(mean_x = mean(x),
            mean_y = mean(y),
            sd_x = sd(x),
            sd_y = sd(y),
            cor = cor(x,y),
            n = n())

# ggplot
df <- read.csv('https://goo.gl/v7nvho', stringsAsFactors = FALSE)

ggplot(data = df, aes(x = CorpusFrequency, y = GivenScore))+
  geom_point()

df %>% 
  ggplot(aes(CorpusFrequency, GivenScore))+
  geom_point()

df %>% 
  ggplot(aes(CorpusFrequency, GivenScore, color = 'red'))+
  geom_point()+
  geom_smooth()

df %>% 
  ggplot(aes(Age, GivenScore, color = Gender))+
  geom_point()+
  geom_smooth()

df %>% 
  ggplot(aes(Age, GivenScore))+
  geom_point()+
  geom_smooth(aes(color = Gender))

df %>% 
  ggplot(aes(Age, GivenScore, shape = Gender))+
  geom_point()

df %>% 
  ggplot(aes(CorpusFrequency, GivenScore, size = Age))+
  geom_point()

df %>% 
  ggplot(aes(CorpusFrequency, GivenScore, size = Age, color = Gender))+
  geom_point()

quartet %>% 
  filter(dataset == 'I') %>% 
  ggplot(aes(x, y))+
  geom_point()+
  labs(x = 'measure 1', y = 'measure 2', 
       title = 'Measures 1 and 2', 
       subtitle = 'Measured in 1973',
       caption = 'Measured by Anscombe, F. J.')+ # legend
  theme_bw()

## logarithmic scale +
## scale_y_log10()
link_freq <-  'https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/freqrnc2011.csv' # freqdict

quartet %>% 
  ggplot(aes(x, y, label = dataset, color = dataset))+
  geom_text()

quartet %>% 
  ggplot(aes(x, y, label = dataset, fill = dataset))+
  geom_label()

quartet %>% 
  ggplot(aes(x, y, color = dataset))+
  geom_point()+
  geom_vline(aes(xintercept = mean(x)), size = 2, color = 'lightblue')+
  geom_hline(aes(yintercept = mean(y)), linetype = 2)+
  annotate(geom = 'rect', xmin = 12.5, xmax = 13.5, 
           ymin = 12.24, ymax = 13.24, fill = 'lightblue', alpha = 0.5)+
  annotate(geom = 'text', x = 13, y = 12, label = 'Who is this\n Outlier?')

quartet %>% 
  ggplot(aes(x, y, color = dataset))+
  geom_point()+
  geom_rug()

df2 <- read.csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/daghestanian_multilingualism.csv', stringsAsFactors = FALSE)

df2 %>% 
  ggplot(aes(sex))+
  geom_bar()

df2 %>%
  ggplot(aes(index, 2018 - year_of_birth_dec, fill = sex))+
  geom_col()+
  coord_flip()

df2 %>%
  ggplot(aes(sex, 2018 - year_of_birth_dec))+
  geom_boxplot()

quartet %>%
  ggplot(aes(dataset, y, color = dataset))+
  geom_boxplot()

quartet %>%
  ggplot(aes(dataset, y, fill = dataset))+
  geom_boxplot()+
  geom_point()

quartet %>%
  ggplot(aes(dataset, y, fill = dataset))+
  geom_boxplot(outlier.alpha = 0)+
  geom_jitter(width = 0.1)

quartet %>%
  ggplot(aes(dataset, y, fill = dataset))+
  geom_violin()+
  geom_jitter(width = 0.1)

homo <- read.csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/Chi.kuk.2007.csv', stringsAsFactors = FALSE)
homo %>% 
  ggplot(aes(s.duration.ms))+
  geom_histogram()

nclass.Sturges(homo$s.duration.ms) # methods of choosing beens number
nclass.scott(homo$s.duration.ms)
nclass.FD(homo$s.duration.ms)

homo %>% 
  ggplot(aes(s.duration.ms))+
  geom_histogram(bins = nclass.FD(homo$s.duration.ms), fill = 'lightblue')

homo %>% 
  ggplot(aes(s.duration.ms, fill = orientation))+
  geom_density(alpha = 0.5)

install.packages('ggridges')
library(ggridges)
homo %>% 
  ggplot(aes(s.duration.ms, orientation, fill = orientation))+
  geom_density_ridges()


# facet
library(dplyr)
homo %>%
  mutate(older_23 = ifelse(age > 23, 'over_23', 'under_23')) %>% 
  ggplot(aes(s.duration.ms, vowel.duration.ms))+
  geom_point()+
  facet_wrap(~orientation+older_23, scales = 'free_x') # 'free' 'free_y'

homo %>%
  ggplot(aes(s.duration.ms, vowel.duration.ms))+
  geom_point(data = homo[, -9],
             aes(s.duration.ms, vowel.duration.ms),
             color = 'grey')+
  geom_point()+
  facet_wrap(~orientation)

homo %>%
  mutate(older_23 = ifelse(age > 23, 'over_23', 'under_23')) %>% 
  ggplot(aes(s.duration.ms, vowel.duration.ms))+
  geom_point(data = homo[, -9],
             aes(s.duration.ms, vowel.duration.ms),
             color = 'grey')+
  geom_point()+
  facet_grid(older_23~orientation, margins = TRUE)
