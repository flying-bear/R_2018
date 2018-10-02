#strings
s <- 'string' # string
v <- c('a', 'b', 'c') # string vector

double_quotes_in_string <- 'i "liked" that'
single_qote_in_string <- "i'm looking forward to meeting you again"

letters # vector of non-capital latin letters
LETTERS # vector of capital latin letters
month.name # vector of the names of the months
month.abb # vector of the abbreviated names of the months

df1 <- data.frame(text = c('a', 'b'), # as factors(
                 numbers = c(1, 4))

df2 <- data.frame(text = c('a', 'b'), # not as factors)
                 numbers = c(1, 4),
                 stringsAsFactors = FALSE)

data <- read.csv('https://goo.gl/v7nvho', stringsAsFactors = FALSE) # not as factors)

library(tidyverse)
tibble::data_frame(text = c('a', 'b'), # not as factors) 
                   numbers = c(1, 4))  #:: = take data_frame function without loading the whole library
readr::read_csv('https://goo.gl/v7nvho')# not as factors)

  #stringi
stringi::stri_rand_strings(10, 4) # 10 random strings of length 4
stringi::stri_rand_strings(10, 4, pattern = '[а-я]') # pattern = which set of characters

stringi::stri_rand_shuffle('abcdef') # shuffles things inside a string

stringi::stri_rand_lipsum(2) # number of paragraphs filled with LOREM IPSUM

# changing strings
str <- 'thE QuiCK BroWn fox juMps Over the lazy dOg'
tolower(str) # gets a string to lower register
toupper(str) # gets a string to upper register

  #stringr
stringr::str_to_lower(str) # gets a string to lower register
stringr::str_to_upper(str) # gets a string to upper register
stringr::str_to_title(str) # gets all the words to start with a capital letter

# sorting strings
str2 <-  c('i', 'n', 'y', 'a', 'N')
sort(str2) # sorts latin letters alphabetically non-capital first
str3 <-  c('з', 'ф', 'р', 'З', 'ч')
sort(str3) # sorts cyrrilic letters alphabetically capital first
sort(str2, decreasing = TRUE) # decreasing order

stringi::stri_sort(str2, locale = 'lt') # locale - the alphabet (lithuanian in this example)

str4 <- c('i','з', 'ф', 'р', 'З', 'ч')
sort(str4)
stringi::stri_sort(str4, locale = 'uk') # ukranian (DOES NOT WORK ALPHABETICALLY!)

nchar('gjgjk2h hh') # count all the characters in string
length(str) # vector length
stringr::str_length(str) # count all the characters in string

  # sorting speed
set.seed(42)
huge <-  sample(letters, 1e7, replace = TRUE) # make million simbol length vector
head(huge) # first n of them

system.time(
  sort(huge)
) #counts time of happenings in parenthesis (a lot of time (e=89s))

system.time(
  sort(huge, method = 'radix') # (least time (e=1.2s))
)

system.time(
  stringr::str_sort(huge) # (somwhere in the middle (e=27.8s))
) 

# joining strings
rus_abc <- c('А', 'Б', 'В', 'Г')
lat_abc <- c('A', 'B', 'C', 'D')

paste(rus_abc, lat_abc) # c( "А A", "Б B", "В C", "Г D")
paste0(rus_abc, lat_abc) # c("АA", "БB", "ВC", "ГD") # sep = ''
paste0(rus_abc, 'F') # c("АF", "БF", "ВF", "ГF")
paste0(rus_abc, c('F', 'A')) #c("АF", "БA", "ВF", "ГA")
paste(rus_abc, lat_abc, sep='*') # sep - separator #c("А*A", "Б*B", "В*C", "Г*D")

paste(rus_abc, collapse = '_') # glue together a vector of char separated by 'collapse symbol'
paste(rus_abc, lat_abc, collapse = '_') #first vector join and then collapse # "А A_Б B_В C_Г D"
paste(rus_abc, lat_abc, sep = '*', collapse = '_')

stringr::str_c(rus_abc, lat_abc) # c("АA", "БB", "ВC", "ГD") # sep = ''
stringr::str_c(rus_abc, lat_abc, sep = '*', collapse = '_') #"А*A_Б*B_В*C_Г*D"

# search in string
a <- c('the quick', 'brown fox', 'jumps', 'over the lazy dog')
grep('the', a) # gives back indices where found
grep('the', a, value = TRUE) # gives back elements where found
grep('the', a, invert = TRUE) # does not give back indices where found
grep('the', a, invert = TRUE, value = TRUE)
grepl('the', a) # logical TRUE if found FALSE else

stringr::str_which(a, 'the') # gives back indices where found
stringr::str_subset(a, 'the') # gives back elements where found
stringr::str_detect(a, 'the') # logical TRUE if found FALSE else
stringr::str_view(a, 'o') # shows in the viewer the first instance found in this line
stringr::str_view_all(a, 'o') # shows in the viewer all instances found
stringr::str_locate(a, 'the') # a matrix: NA if not found, 
                              # start - the index of the first symbol of the first instance, 
                              # end - the index of the last symbol of the first instance
stringr::str_locate_all(a, 'o') #list format (

# replace a part of a string
b <- c('the quick fox', 'jumps over the lazy dog')
sub('o', '_', b) # replace first instance of what, by what, in which string vector
gsub('o', '_', b) # replace all inctances
stringr::str_replace(b, 'o', '_') # replace in which string vector, first instance of what, by what
stringr::str_replace_all(b, 'o', '_') # replace all inctances

# split
strsplit(b, ' ') # split what by what (returns a list if given a vector)
unlist(strsplit(b, ' ')) # creates a vector from a list
stringr::str_split(b, ' ') # list if given a vector
stringr::str_split(b, ' ', simplify = TRUE) # returns a matrix

# substrings
substring(b, 11, 15) #substring of what from a start to an end (or the end)
substring(b, c(5, 16), c(9, 19)) # from 5 to 9 and from 16 to 19
substring('а роза упала на лапу азора', 1:26, 1:26) # all the characters of this string
substring('мат и тут и там', 1:15, 15:1) # cutting from both ends
stringr::str_sub(b, 11, 15)
stringr::str_sub(b, c(5, 16), c(9, 19))
stringr::str_sub('а роза упала на лапу азора', 1:26, 1:26)
stringr::str_sub('мат и тут и там', 1:15, 15:1)
stringr::str_sub(b, -3, -1) # form the end

#