library(tidyverse)
library(ggplot2)
df <- read.csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/Endresen_Laura_2015_acceptability_judgments.csv', stringsAsFactors = FALSE, sep = ';')
str(df)

### descriptive statistics
mean(df$GivenScore) # mean
mean(df$GivenScore, trim = 0.1) # leaving marginal 0.1 out
median(df$GivenScore) # median
min(df$GivenScore)
max(df$GivenScore)
range(df$GivenScore) # min max
quantile(df$GivenScore, probs = 0.25)
quantile(df$GivenScore, probs = 0.45)
quantile(df$GivenScore, probs = 0.75)
IQR(df$GivenScore) # interquartile ratio = quantile(0.75) - quantile(0.25)

sd(df$GivenScore) # standard deviation (square root of dispersion)

a <- c(1:10, NA)
mean(a, na.rm = TRUE) # na.rm - remove NAs (most functions have it)
quantile(a, na.rm = TRUE)

# contingency table
table(df$Gender) 
b <- table(df$Education) # type table ~ vector with names
names(b) # names of variables
sum(b) # sums values

table(df$Gender, df$Education)/7260
prop.table(table(df$Gender, df$Education)) # the same, proportions

# distributions
set.seed(0) # fixate randomization to reproduce the same random dataset
rnorm(100) # 100 random normally distributed values
rnorm(100, mean = 100, sd = 25)
dnorm(90:140, mean = 100, sd = 25) # density function of a normal distribution
plot(dnorm(0:200, mean = 100, sd = 25))
qnorm(0.4, mean = 100, sd = 25) # 0.4 quantile of a normal distribution 

rt(n = 100, df = 7) # t-distribution
dt(x = 10:20, df = 7) # density function of a t-distribution
qt(0.3, df = 7) # 0.3 quantile of a t-distribution

rchisq(10, df = 7, ncp = 0) # chi-squared distribution ncp - non-centrality parametr, non-negative
dchisq(10:12, df = 7, ncp = 0) # https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Chisquare.html
qchisq(0.1, df = 7, ncp = 0)

rbinom(10, size = 10, prob = 0.5) # binomial distribution
dbinom(10:15, size = 10, prob = 0.5) # https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Binomial.html
qbinom(0.5, size = 10, prob = 0.5)


# z-transformation, z-score, normalization
scale(df$Age) # scale - normalization z-function 

df %>% 
  group_by(SubjectCode) %>% 
  mutate(ScaledScore = scale(GivenScore)) %>% # scale - normalization z-function 
  select(GivenScore, ScaledScore) # can compare within subject range


### inferential statistics

# 1. what questions will we try to answer?
# 2. which types of data will be collected?
# 3. how many data points we'll need for certain statistical power?
# 4. simulate data on different data types and infer possible results
# 5. what answers will we derive from certain results?
# 6. collect data
# 7. visualize data
# 8. analyze outliers
# 9. analize data as planned
# 10. infer answers from obtained results

# stats: frequentist statiscs vs bayesian statistics vs simulation statistics
# we will discuss frequentist statiscs

# tests: parametric vs non-parametric
# tests: 1 samples, 2 samples, and many samples tests
# tests: paired vs independent
# tests: one- vs two- tailed tests (two-tailed used here as default)

# confidence interval = mean(x) +- z-score * sigma/sqrt(n)
# visualistion: http://rpsychologist.com/d3/CI/
df %>% 
  group_by(SubjectCode) %>% 
  mutate(ScaledScore = scale(GivenScore)) -> df

df %>% 
  group_by(WordType) %>% 
  summarise(mean = mean(ScaledScore), 
            ci_min = mean - 1.96*sd(ScaledScore)/sqrt(n()),
            ci_max = mean + 1.96*sd(ScaledScore)/sqrt(n())) %>% 
  ggplot(aes(WordType, mean, 
            ymin = ci_min,
            ymax = ci_max))+
  geom_point() # points only, no confidence intervals

df %>% 
  group_by(WordType) %>% 
  summarise(mean = mean(ScaledScore), 
            ci_min = mean - 1.96*sd(ScaledScore)/sqrt(n()),
            ci_max = mean + 1.96*sd(ScaledScore)/sqrt(n())) %>% 
  ggplot(aes(WordType, mean, 
             ymin = ci_min,
             ymax = ci_max))+
  geom_errorbar() # the best; confidence intervals don't intersect! => let's calculate p-values!

df %>% 
  group_by(WordType) %>% 
  summarise(mean = mean(ScaledScore), 
            ci_min = mean - 1.96*sd(ScaledScore)/sqrt(n()),
            ci_max = mean + 1.96*sd(ScaledScore)/sqrt(n())) %>% 
  ggplot(aes(WordType, mean, 
             ymin = ci_min,
             ymax = ci_max))+
  geom_linerange() # nothing visible :(

# t-test, REQUIRES THE DISTRIBUTION TO BE NORMAL
shiny::runGitHub('agricolamz/t_distr_app') # an app, showing how t-distribution approaches normal with rising dfs

df %>% 
  filter(WordType == 'marginal') %>% 
  select(ScaledScore) -> marginal

shapiro.test(marginal$ScaledScore) # Shapiro-Wilk test (a formal test of distribution normality: 
                                   #                     p < 0.01 means it's probably not)
                                   # https://stat.ethz.ch/R-manual/R-devel/library/stats/html/shapiro.test.html

# OH WE SHOULD NOT DO THIS AS THE DISTRIBUTION IS NOT NORMAL!
t.test(marginal$ScaledScore, mu = 0) # one sample two-tailed t-test (wether the mean differs from 4)
                                     # https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html
ttest_marginal <- t.test(marginal$ScaledScore, mu = 0)
ttest_marginal$statistic # t-score
ttest_marginal$p.value # p-value

t.test(sample(marginal$ScaledScore, 100), mu = 0) # sample(vector, n) takes n random different elements from a given vector
t.test(sample(marginal$ScaledScore, 1000), mu = 0)

# visual normality testing
marginal %>% 
  ggplot(aes(ScaledScore))+
  geom_histogram(bins = nclass.Sturges(marginal$ScaledScore))

marginal %>% 
  ggplot(aes(ScaledScore))+
  geom_density()

marginal %>% 
  ggplot(aes(sample = ScaledScore))+
  stat_qq() # quantile-quantile plot (normal vs sample; if sample is normal the line is straight diagonal)

# Wilcoxon test (non-parametric)
wilcox.test(marginal$ScaledScore, mu=0)


# binomial test
expected_kenguru <- 0.0000021 # frequency dictionary value
expected_k <- 0.005389 # frequency dictionary value
n <- 61981 # number of words in a given story
observed_kenguru <- 58 # number of encounters in the story
observed_k <- 254 # number of encounters in the story
binom.test(observed_kenguru, n, expected_kenguru) # observed == expected as the null hypohesis (kenguru is too frequent)
binom.test(observed_k, n, expected_k) # (k is too rare)

# p-value != effect size !!!