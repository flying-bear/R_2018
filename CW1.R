# comment
2 + 3 # = 5
3 - 5 # = -2
23^9 #= 23**9
sum(1, 4, 5)
prod(1, 4, 5)
log(9)
exp(3)
cos(3)
sin(4)

choose(10, 3) #10 chooses 3

pi
exp(1) #= e

exp(2/(1-pi))

#objects
typeof(54) #"double"
typeof(-39.4) #"double"
typeof(-39.4 + 5i) #"complex"
typeof('Andrey Lloyd') #"character"
typeof(TRUE) #=typeof(FALSE) =typeof(T) = typeof(F) #"logical"
typeof(Inf) #"double"
typeof(NA) #"logical"
typeof(NA_character_) #"character"

#variables
x <- 21
x #21
x+3 #24
x <- x+3 #24 #"alt"+"-" = "<-"

#factor
education <- c('higher', 'school', 'nursery school', 'higher', 'school', 'nursery school')
education <- factor(education, levels = c('nursery school', 'school', 'higher'))
education


#vector ~list of one type elements
3:8 #3 4 5 6 7 8
c(3, 4, 5, 6, 7, 8) #from 'concatenate' #3 4 5 6 7 8
length(100:1) #100
c(TRUE, FALSE, TRUE) #TRUE FALSE TRUE
v = c('a', 'b', 'c')
v[1] #"a"
v[1:3] #'a' 'b' 'c'
numeric_vector <- c(5:10)
numeric_vector %% 2 #%% остаток от деления #1 0 1 0 1 0 
numeric_vector %% 2 == 1 # TRUE FALSE TRUE FALSE TRUE FALSE
numeric_vector[numeric_vector %% 2 == 1] #numbers in numeric_vector that are not divisible by 2 #5 7 9
numeric_vector + 1 #one element vector #6 7 8 9 10 11
1:3 + 3:1 #same lengths vectors sum #4 4 4

v <- c(700:1000)
v[v %% 43 == 0]

#sequence generator
seq(0, 0.5, by = 0.1) #sequence: from, to, by, length.out #0.0 0.1 0.2 0.3 0.4 0.5
?seq #help or Fn+F1
seq(10, length.out = 100, by=7)

#random distributions
rnorm(100, 0, 1) #normal distribution: n, mean, SD
rt() #student t-distribution
rbinom() #binomial distribution
rchisq() #chi-squared distribution

set.seed(1) #the same random set

#matricies can be myltiplied, added etc
matrix(1:16, ncol=4, byrow = TRUE) #nrow = 4
array(1:4, 1:4) #dim=4

#conversion
c(1:7, 'my') #numbers -> characters, TRUE->1, FALSE->0, TRUE -> 'TRUE'

#list
list(c(TRUE,FALSE), 
     c('a', 'b', 'c'),
     6)

#Data.frame list of the same length vectors (name = vector of entities)
df <-  data.frame(logic = c(TRUE, FALSE, TRUE), 
                  letters = c('a', 'b', 'c'),
                  numbers = c(1.2, 6, 8.03),
                  stringsAsFactors = FALSE) #ensure no factorisation happens to our string vectors
df$letters #vector of letters
df$letters[1] #'a'
df[2, 2] #[raw, column] #'b' 
df[2, 'numbers'] #6
df[2:3, 'numbers'] #6 8.3
df[2:3,] #first two raws
df[df$numbers > 2] #only raws with 6 and 8.03 in numbers

#functions
cube <- function(x){
  x^3
}

cube(3) #27
cube(1:3) #vectorized function #1 8 27 

plus <- function(x, y){
  x + y
}

plus(1, 2) #3
plus(y=2, x=3) #5

is_odd <- function(x){
  i %% 2 == 1
}

is_odd(1) #TRUE
is_odd(2) #FALSE

is_odd <-  function(x){
  if(i %% 2 == 1){
    'this number is odd'
  } else {
    'this number is even'
  }
}

#the same function can be written as ifelse(condition, if_true, if_false)
is_odd <-  function(x){
  ifelse(i %% 2 == 1, 'this number is odd', 'this number is even')
}

#integrate
?integrate
f <- function(x){sin(x)^3/(sin(x)^3 + cos(x)^3)}
integrate(f, 0, pi/2)

#packages
install.packages('lingtypology') #install
library(lingtypology) #import (plugin)
map.feature(c('Adyghe', 'Russian', 'Modern Hebrew'))
wals #WALS package built-in data.frame (wals.info & glottolog.com)
detach(lingtypology) #plugout

install.packages('phonTools')
library(phonTools)
pickIPA(n = 1)
detach(phonTools)

#built-in vectors
letters
LETTERS
month.name
month.abb

#built-in data.frame
iris
