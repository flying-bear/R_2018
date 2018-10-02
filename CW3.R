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

# transliteration
stringi::stri_trans_general('Garik', 'latin-cyrillic')
stringi::stri_trans_general('Гарик Мороз', 'cyrillic-latin')
stringi::stri_trans_general('Garik', 'latin-greek')
stringi::stri_trans_general('Garik', 'latin-armenian')

# make strings look shorter
s <- 'a string which is considered to be too long'
stringr::str_trunc(s, 20, 'right')
stringr::str_trunc(s, 20, 'left')
stringr::str_trunc(s, 20, 'center')

# make strings look longer
w <- 'too short'
stringr::str_pad(w, 20, 'right')
stringr::str_pad(w, 20, 'left')
stringr::str_pad(w, 20, 'both')

# identify language
udhr_24 <- c('Everyone has the right to rest and leisure, including reasonable limitation of working hours and periodic holidays with pay.',
             'Toute personne a droit au repos et aux loisirs, y compris une limitation raisonnable du temps de travail et des congés payés périodiques.',
             'Каждый человек имеет право на отдых и досуг, включая разумное ограничение рабочего времени и периодических отпусков.',
             'לכל אחד יש את הזכות לנוח ולפנאי, כולל הגבלה סבירה של שעות עבודה וחגים תקופתיים עם שכר.',
             '每個人都有權休息和休閒，包括合理限制工作時間和定期帶薪休假。',
             '모든 사람은 합당한 근무 시간 제한과 정기적 인 휴일 휴가를 포함하여 휴식과 여가를 누릴 권리가 있습니다.',
             'प्रत्येक व्यक्ति को आराम और अवकाश का अधिकार है, जिसमें कामकाजी घंटों की उचित सीमा और वेतन के साथ आवधिक छुट्टियां शामिल हैं।')
install.packages('cld2')
install.packages('cld3')
cld2::detect_language(udhr_24)
cld2::detect_language(udhr_24, lang_code = FALSE) # full language names
cld3::detect_language(udhr_24)
cld2::detect_language('Ты женат? Говорите ли по-английски?') #bulgarian((
cld3::detect_language('Ты женат? Говорите ли по-английски?') # no idea ((
cld2::detect_language('Хливкие шорьки Пырялись по наве, И хрюкотали зелюки, Как мюмзики в мове.') #works
cld3::detect_language('Хливкие шорьки Пырялись по наве, И хрюкотали зелюки, Как мюмзики в мове.') #works
cld2::detect_language("Варчилось, хлив'язкi тхурки викрули, свербчись навкрузi, жасумновiлi худоки гривiли зехряки в чузi") # no idea
cld3::detect_language("Варчилось, хлив'язкi тхурки викрули, свербчись навкрузi, жасумновiлi худоки гривiли зехряки в чузi") # works
cld2::detect_language_mixed('мы не используем code mixing on daily basis') # mixed languages
cld3::detect_language_mixed('мы не используем code mixing on daily basis') # mixed languages

# string distance measaures
stringdist::stringdist('корова', 'корова')
stringdist::stringdist('коровы', c('корова', 'осёл', 'курица'))
stringdist::stringdistmatrix(c('башкирия', 'республика карачаево-черкессия', 'татарстан'), c('башкиртостан', 'республика татарстан', 'карачаево-черкесская республика'))
stringdist::stringsim('коровы', c('корова', 'осёл', 'курица')) # from 0 to 1
stringdist::amatch(c('коровы', 'быки'), c('корова', 'быки', 'курица'))
stringdist::ain(c('осы', 'корова'), c('тигр', 'ослы', 'коровы', 'попугай', 'осы')) # maxdist din't work((

# special symbols
a <- 'всем известно что 45\\2 + 3$ + 5 = 17$7 Да? Ну хорошо (а то я не был уверен.) [{^|^}]'
stringr::str_view_all(a, '$') # nothing found - $ is reserved for the beginning of the line
stringr::str_view_all(a, '\\$')
stringr::str_view_all(a, '\\.')
stringr::str_view_all(a, '\\*')
stringr::str_view_all(a, '\\+')
stringr::str_view_all(a, '\\?')
stringr::str_view_all(a, '\\^')
stringr::str_view_all(a, '\\)')
stringr::str_view_all(a, '\\(')
stringr::str_view_all(a, '\\[')
stringr::str_view_all(a, '\\]')
stringr::str_view_all(a, '\\{')
stringr::str_view_all(a, '\\}')
stringr::str_view_all(a, '\\|')
stringr::str_view_all(a, '\\\\')


# regular expressions in R
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '\\d') #\\d = all the digits
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '\\D') #\\D = everything except the digits
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '\\s') #\\s = spaces, tabs etc
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '\\S') #\\S = everything except spaces, tabs
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '\\w') #\\w = words (everything between spaces and punctuation)
stringr::str_view_all('Умей мечтать, не став рабом мечтанья', '[оауыэюияёе]') # vowels
stringr::str_view_all('И мыслить, мысли не обожествив', '[^оауыэюияёе]') # everyting except vowels
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '[4-9]') # numbers from 4 to 9
stringr::str_view_all('карл у клары украл кораллы, а клара у карла украла кларнет', '[а-я]') # cyrillic non capital letters
stringr::str_view_all('Карл у Клары украл кораллы, а Клара у Карла украла кларнет', '[A-я]') # cyrillic letters
stringr::str_view_all('The quick fox jumps over the lazy dog.', '[A-z]') # latin letters
stringr::str_view_all('два 15 42, 42 15, 37 08 5, 20 20 20!', '[^4-9]') # everything but 456789
stringr::str_view_all('Карл у Клары украл кораллы, а Клара у Карла украла кларнет','лар|рал|арл')
stringr::str_view_all('Везет Сенька Саньку с Сонькой на санках. Санки скок, Сеньку с ног, Саньку в бок, Соньку в лоб, все в сугроб.', '[Сс].н') # . - any symbol
stringr::str_view_all('от топота копыт пыль по полю летит', '^о') # ^ - at the beginning of the string
stringr::str_view_all('у ужа - ужата, у ежа - ежата', 'жата$') # $ - at the end of the string

  # quantification in regular expressions in R
stringr::str_view_all('хорошее длинношеее животное', 'еее?') #? means not necessary
stringr::str_view_all('хорошее длинношеее животное', 'ее*') # * means zero ore more times
stringr::str_view_all('хорошее длинношеее животное', 'е+') # + means one or more times
stringr::str_view_all('хорошее длинношеее животное', 'е{2}') # {n} means exactly n times
stringr::str_view_all('хорошее длинношеее животное', 'е{1,}') # {n,m} means from n to m times #no space is allowed {n, m} is wrong
stringr::str_view_all('хорошее длинношеее животное', 'е{1,2}') # {n,m} means from n to m times
stringr::str_view_all('Пушкиновед, Леромнтовед, Леромнтововед', '(ов)+') # () groups symbols
stringr::str_view_all('красноватый, беловатый, розоватый, розововатй', '(ов)+')
stringr::str_view_all('Пушкиновед, Леромнтовед, Леромнтововед', 'в.*ед') # .* means repeat . zero or more times between в and the last ед (greedy quantifier)
stringr::str_view_all('Пушкиновед, Леромнтовед, Леромнтововед', 'в.*?ед') # .*? means repeat . zero or more times between в and ед - stop after first ед found (not greedy quantifier)
