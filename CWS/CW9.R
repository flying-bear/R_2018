## logistic regression: categorical data prediction
library(tidyverse)
df <- data_frame(n = 10,
                 success = 1:9,
                 failure = 9:1,
                 prob = success/sum(success, failure),
                 odds = success/failure,
                 log.odds = log(odds))

ejectives <- lingtypology::ejective_and_n_consonants
str(ejectives) # structure
ejectives$ejectives <- factor(ejectives$ejectives)

#generalized linear model
fit0 <- glm(ejectives~1, data = ejectives, family = 'binomial')
table(ejectives$ejectives)
i <- as.numeric(fit0$coefficients[1])
round(6/(13+6), digits = 7) == round(exp(i)/(1+exp(i)), digits = 7)
# what it means is basically 6/(13+6) = exp(i)/(1+exp(i))

fit1 <- glm(ejectives~consonants, data = ejectives, family = 'binomial')
# log(ej/non-ej) = -12.1123 + 0.4576 * consonants + epsilon

ejectives %>% 
  ggplot(aes(consonants, ejectives))+
  geom_point()

ejectives %>%
  mutate(ejectives = as.integer(ejectives) - 1) %>% 
  ggplot(aes(consonants, ejectives))+
  geom_point()+
  geom_smooth(method = 'glm', 
              method.args = list(family = 'binomial'))+
  labs(y = 'probability of ejectives')

ejectives %>%
  mutate(ejectives = as.integer(ejectives) - 1,
         consonants = consonants + 100) %>%  # add a 100 to the consonant number
  ggplot(aes(consonants, ejectives))+
  geom_point()+
  geom_smooth(method = 'glm', 
              method.args = list(family = 'binomial'))+
  labs(y = 'probability of ejectives')

ejectives %>%
  mutate(ejectives = as.integer(ejectives) - 1,
         consonants = consonants * 2) %>% # double the number of consonants
  ggplot(aes(consonants, ejectives))+
  geom_point()+
  geom_smooth(method = 'glm', 
              method.args = list(family = 'binomial'))+
  labs(y = 'probability of ejectives')

ejectives %>%
  mutate(ejectives = as.integer(ejectives) - 1,
         consonants = - consonants) %>% # negative number of consonants
  ggplot(aes(consonants, ejectives))+
  geom_point()+
  geom_smooth(method = 'glm', 
              method.args = list(family = 'binomial'))+
  labs(y = 'probability of ejectives')

# predictions
# log(ej/non-ej) = -12.1123 + 0.4576 * consonants + epsilon
log_ej_nej <- -12.1123 + 0.4576 * 29
exp(log_ej_nej)/(1+exp(log_ej_nej))
predict(fit1) # log(odds)
prediction <-  predict(fit1, type = 'response', newdata = data.frame(consonants = 29))
round(exp(log_ej_nej)/(1+exp(log_ej_nej)), digits = 2) == round(as.numeric(prediction), digits = 2)
predict(fit1, type = 'response', newdata = data.frame(consonants = c(29, 9, 49)))
predict(fit1, type = 'response', newdata = data.frame(consonants = c(1:50)))

# model with a dummy-variable
ejectives$area <- lingtypology::area.lang(ejectives$language)
fit <- glm(family = 'binomial', data = ejectives, 
           formula = ejectives~area)
summary(fit)
table(ejectives$area, ejectives$ejectives)

# multiple logistic regression
fit1 <- glm(family = 'binomial', data = ejectives, 
           formula = ejectives~area)
fit2 <- glm(family = 'binomial', data = ejectives, 
           formula = ejectives~consonants)
fit3 <- glm(family = 'binomial', data = ejectives, 
            formula = ejectives~vowels)
fit4 <- glm(family = 'binomial', data = ejectives, 
            formula = ejectives~consonants+vowels)
fit5 <- glm(family = 'binomial', data = ejectives, 
            formula = ejectives~vowels+area)
fit6 <- glm(family = 'binomial', data = ejectives, 
            formula = ejectives~consonants+area)
fit7 <- glm(family = 'binomial', data = ejectives, 
            formula = ejectives~consonants+vowels+area) # there is a collinearity

AIC(fit1, fit2, fit3, fit4, fit5, fit6, fit7) # minimum is the best except fit7 is baaad
BIC(fit1, fit2, fit3, fit4, fit5, fit6, fit7) # fit2 is the best

install.packages('pscl')
library(pscl)
pscl::pR2(fit1)
pscl::pR2(fit2)
pscl::pR2(fit3)
pscl::pR2(fit4)
pscl::pR2(fit5)
pscl::pR2(fit6)
pscl::pR2(fit7)

## multinomial regression
nanai <- read_csv('https://raw.githubusercontent.com/agricolamz/r_on_line_course_data/master/nanai_vowels.csv')

nanai %>% 
  ggplot(aes(f2, f1, label = sound, color = sound))+
  geom_text()+
  scale_x_reverse()+
  scale_y_reverse()+
  stat_ellipse()

install.packages('nnet')
fit <- nnet::multinom(sound~f2+f1, data = nanai)
summary(fit)

# log(e/I) = 40.88723 - 0.019158918*f2 - 0.02304564*f1
# log(i/I) = 18.15082 + 0.003943656*f2 - 0.06590407*f1

predict(fit, newdata = data.frame(f2 = 2000, f1 = 500)) # I
predict(fit, newdata = data.frame(f2 = 1000, f1 = 500)) # e
predict(fit, newdata = data.frame(f2 = 2000, f1 = 300)) # i

nanai %>% 
  mutate(predicted = predict(fit),
         wrong = if_else(sound != predicted, TRUE, FALSE)) %>% 
  ggplot(aes(f2, f1, label = sound, color = sound))+
  geom_text(aes(size = wrong))+
  scale_x_reverse()+
  scale_y_reverse()+
  stat_ellipse()
