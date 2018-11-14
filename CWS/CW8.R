## linear regressions: one dependent variable and a lot of predictors
library(tidyverse)
shiny::runGitHub('agricolamz/regression_app')
np_acquisition <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/Huttenlocher_2001.csv')

np_acquisition %>% 
  ggplot(aes(mother, child))+
  geom_point()+
  geom_hline(aes(yintercept = mean(child)), color = 'blue') # just drawing the mean for child variable


np_acquisition %>% 
  ggplot(aes(mother, child))+
  geom_point()+
  geom_smooth(method = 'lm', se = FALSE) # lm - linear model, se - showing confidence intervals for linear regression

lm(np_acquisition$child~np_acquisition$mother) # returns coefficients
lm(child~mother, data = np_acquisition) # the same

fit <- lm(child~mother, data = np_acquisition)
summary(fit) # some more info on our linear model including R squared (residual sum of squares (rss))
             # R-squared = 1- (rss for lm/rss for mean)

np_acquisition$predicted <- predict(fit)

np_acquisition %>% 
  mutate(delta = child - predicted) %>% 
  ggplot(aes(delta))+
  geom_density() # mistakes density plot

predict(fit, newdata = data.frame(mother = c(1, 1.5, 2))) # predictions for unseen data

np_acquisition %>% 
  ggplot(aes(mother, child))+
  geom_point()+
  geom_smooth(method = 'lm')

ejectives <- lingtypology::ejective_and_n_consonants

ejectives %>% 
  ggplot(aes(ejectives, consonants))+
  geom_boxplot()+
  geom_jitter(width = 0.1)

lm(formula = consonants ~ ejectives, data = ejectives) # basicaly the mean of no ejectives and the differnce between the groups

ejectives %>% 
  group_by(ejectives) %>% 
  summarize(mean(consonants))

fit2 <- lm(formula = consonants ~ ejectives+vowels, data = ejectives)
summary(fit2)

fit0 <- lm(consonants~1, data = ejectives) # consonants = b0
fit1 <- lm(consonants~ejectives - 1, data = ejectives) # consonants = b1*ejectives
fit2 <- lm(consonants~ejectives, data = ejectives) # consonants = b0 + b1*ejectives
fit3 <- lm(consonants~ejectives+vowels, data = ejectives) # consonants = b0 + b1*ejectives + b2*vowels

s0 <- summary(fit0)
s1 <- summary(fit1)
s2 <- summary(fit2)
s3 <- summary(fit3)

s0$adj.r.squared # the worst adjusted r-squared
s1$adj.r.squared # the best ajusted r-squared
s2$adj.r.squared
s3$adj.r.squared

AIC(fit0, fit1, fit2, fit3) # fit1 ~ fit2 < fit3 < fit0
BIC(fit0, fit1, fit2, fit3) # fit1 ~ fit2 < fit3 < fit0

# choosing the best predictors set from a model with all the possible predictors
fit_best  <- step(fit3, direction = 'both') # chose fit3 basically

# limitations of linar regression: we need to have
# - linear dependence of varibles
# - independent data
# - normal distribution of residuals

cars %>% 
  ggplot(aes(speed, dist))+
  geom_point()+
  geom_smooth(method = 'lm')

lm(dist~speed, data = cars)
