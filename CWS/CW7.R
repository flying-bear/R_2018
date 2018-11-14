library(tidyverse)
## two samples t-test
df1 <- ... # independent variables
df2 <-  ... # dependent paired variables (time course or different measures on the same person)
t.test(df1$LI~df2$HQ) # for long format datasets, group variable after the ~ 

df1[df1$HQ == 'RH', 1] # dataset of one variable
rh <- df1$LI[df1$HQ == 'RH'] # vector
lh <- df1$LI[df1$HQ == 'LH']
shapiro.test(lh) # are these distributions normal?
shapiro.test(rh)
t.test(lh, rh) # for normal distributions
wilcox.test(lh, rh) # forn not normal distributions

t.test(df2$LI.Front, df2$LI.Temp, paired = TRUE) # whether the lateralization of the activations 
                                                # in frontal and temporal lobe are the same
wilcox.test(df2$LI.Front, df2$LI.Temp, paired = TRUE) # doesn't like if there are the several instances of the same value

## about the statistical power http://rpsychologist.com/d3/cohend/

## chi-squared, McNear test, Fisher test
shiny::runGitHub('agricolamz/norm_chisq_app')
t <- read_tsv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/slavic_case_alternation.csv')
t %>% 
  filter(lang == 'rus') -> df1
t %>% 
  filter(lang == 'pol') -> df2
t_rus <- table(df1)
t_pl <- table(df2)
chisq.test(t_rus) # unpaired variables
mcnemar.test(...) # paired variables
test_rus <- chisq.test(t_rus)
addmargins(test_rus$observed) # = addmargins(t_rus)
addmargins(test_rus$expected) # expected values
# df = (number of rows - 1) * (number of columns - 1)
test_pl <- chisq.test(t_pl)
test_pl$expected
# if expected in one of the cells is less than 5 use Fisher test
fisher.test(t_pl)
fisher.test(t_rus) # similar p-value to chi-squared

## multiple testing adjustments
p.adjust(c(0.04, 0.02, 0.001)) # method = 'holm'
p.adjust(c(0.04, 0.02, 0.001), method = 'holm')
p.adjust(c(0.04, 0.02, 0.001), method = 'bonferroni')


## dispersion (adjusted variance), covariation, correlation https://shiny.rit.albany.edu/stat/rectangles/
# Pearson's correlation coefficient = covariation over standard deviation (ranges from -1 to 1)
df <- lingtypology::ejective_and_n_consonants
var(df$vowels)
var(df$consonants) 
sd(df$vowels)
sd(df$consonants)
cor(df$vowels, df$consonants)

df %>% 
  ggplot(aes(vowels, consonants))+
  geom_point()

df %>% 
  group_by(ejectives) %>% 
  summarize(vowel_variance = var(vowels), 
            consonant_variance = var(consonants),
            correlation = cor(vowels, consonants))

df %>% 
  ggplot(aes(vowels, consonants, color = ejectives))+
  geom_point()+
  geom_smooth(method = 'lm')

## multiple variables correlation
df <- lingtypology::ejective_and_n_consonants
homo <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/orientation.csv')
install.packages('GGally')
GGally::ggpairs(homo[, c(2:8)])

homo %>% 
  select(-speaker, -orientation) %>% 
  cor() %>% 
  View() ## turns it into a dataframe

homo %>% 
  select(-speaker, -orientation) %>% 
  cor() %>% 
  as.tibble() %>% 
  mutate(var_name = colnames(.)) %>% # column names in order
  gather(key = var_long, value = cor, s.duration.ms:age) -> homo_cor

homo_cor %>% 
  filter(cor != 1,
         cor != -1) %>% 
  summarise(max(cor), min(cor))

homo_cor %>% 
  filter(cor != 1,
         cor != -1) %>% 
  arrange(cor)

homo_cor %>% 
  filter(cor != 1,
         cor != -1) %>% 
  arrange(desc(cor))

## Pearson's, Spearman's and Kendall's correlation coefficients
df <- data.frame(x = rnorm(n = 100, mean = 100, sd = 25), y = rnorm(n = 100, mean = 100, sd = 25))

df %>% 
  ggplot(aes(x, y))+
  geom_point()

df %>% 
  summarize(cor(x, y)) # 0.773

df %>% 
  ggplot(aes(x^5, y))+
  geom_point()

df %>% 
  mutate(x = x^5) %>% 
  summarize(cor(x, y)) # 0.638

df %>% 
  summarize(p = cor(x, y), # == method = 'pearson' # 0.773
            s = cor(x, y, method = 'spearman'), # 0.771
            k = cor(x, y, method = 'kendal')) # 0.581

df %>% 
  mutate(x = x^5) %>% 
  summarize(p = cor(x, y), # == method = 'pearson' # 0.638 (had changed)
            s = cor(x, y, method = 'spearman'), # 0.771 (hadn't changed) - ranking correlation (which means no confidence intervsla)
            k = cor(x, y, method = 'kendal')) # 0.581 (hadn't changed) - ranking correlation (which means no confidence intervsla)
                                              # (Kenall's is ALWAYS LOWER THAN Spearman's)

cor.test(df$x, df$y) # tests wether Pearson's corellation coefficient equals 0
cor.test(df$x, df$y, method = 'kendal')

