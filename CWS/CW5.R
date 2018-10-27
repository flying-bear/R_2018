# gutenbergr
install.packages('gutenbergr')
library(gutenbergr)
library(tidyverse)
gutenberg_metadata # data on contents of the project (book number, title, author etc)
gutenberg_works() # data on contents with text availible
gutenberg_authors %>% # data on authors
  slice(grep('Austen', author))
gutenberg_works(author == 'Austen, Jane') %>% 
  select(gutenberg_id) -> ids
p_and_p_text <- gutenberg_download(1342)
gutenberg_works() %>% 
  distinct(language)
austen_text <-  gutenberg_download(ids)


gutenberg_metadata %>% 
  count(language) %>% 
  arrange(desc(n))

# tidytext
install.packages('tidytext')
library(tidytext)
p_and_p_text %>% 
  unnest_tokens(word, text) -> tidy_p_and_p # unnest_tokens(new column name, used column name, to_lower = FALSE) 
                                            # the last argument is responsible for keeping rgister
austen_text %>% 
  unnest_tokens(word, text) -> tidy_austen

tidy_p_and_p %>% 
  count(word) %>% 
  arrange(desc(n))

  # stop words
stop_words

tidy_p_and_p %>% 
  count(word) %>% 
  arrange(desc(n)) %>% 
  anti_join(stop_words) %>% 
  anti_join(data.frame(word = c('miss', 'sir', 'mr', 'mrs'))) %>% 
  slice(1:30) %>% 
  ggplot(aes(word, n))+
  geom_col()+
  coord_flip()

  # tf-idf and ngrams
austen_text %>% 
  unnest_tokens(bigrams, text, 
                token = 'ngrams', n = 2) %>% 
  count(bigrams, gutenberg_id) %>% 
  bind_tf_idf(term = bigrams, document = gutenberg_id, n) -> austen_tf_idf

austen_tf_idf %>% 
  mutate(gutenberg_id = factor(gutenberg_id)) %>% 
  arrange(desc(tf_idf)) %>% 
  slice(1:50) %>% 
  ggplot(aes(bigrams, tf_idf, fill = gutenberg_id))+
  geom_col()+
  coord_flip()+
  facet_wrap(~gutenberg_id, scales = 'free')+
  labs(x = '',
       y = 'tf_idf')

# udpipe
install.packages('udpipe')
library(udpipe)
udmodel <- udpipe_download_model(language = 'dutch')
udmodel <-udpipe_load_model(file = udmodel$file_model)
x <- udpipe_annotate(udmodel,
                     x = 'Nå, jeg sprang og skyndte mig efter kaninen, døde af nysgerrighed og blev næsten fanget')
x <- as.data.frame(x)

# lingtypology from Glottolog
install.packages('lingtypology')
library(lingtypology)
glottolog.modified # contents of glottolog database
lang.aff('Slavic') # what we want . what we know
aff.lang('Mam')
long.lang('Mam')
lat.lang('Mam')
lang.country('Russia')
gltc.lang('Mam')
country.lang(c('Adyghe', 'Russian'), intersection = TRUE) # where both are spoken
aff.lang('Arabic') # has a built-in spell-checker
aff.lang('Standard Arabic')
aff.lang('Standard Arabic', glottolog.source = 'original')

  # maps
map.feature(c('Adyghe', 'Russian', 'Mam', 'Modern Hebrew'),
            features = c('feature1', 'feature2', 'feature1', 'feature1'))
map.feature(c('Adyghe', 'Russian', 'Mam', 'Modern Hebrew'),
            features = c('feature1', 'feature2', 'feature1', 'feature1'),
            map.orientation = 'Atlantic')
map.feature(lang.aff('Slavic'))
map.feature(lang.aff('Sign'),
            map.orientation = 'Atlantic')
map.feature(lang.aff('Sign'),
            label = lang.aff('Sign')) # labels without clik needed

ejective_and_n_consonants # built-in dataset
map.feature(languages = ejective_and_n_consonants,
            features = ejective_and_n_consonants$consonants)
map.feature(languages = ejective_and_n_consonants,
            features = ejective_and_n_consonants$ejectives)

  # API for linguists
    # WALS (the World Atas of Language Structures)
wals.feature('1a') -> w # don't forget to cite things properly!
map.feature(language = w$language, # consonant inventory
            features = w$`1a`,
            longitude = w$longitude,
            latitude = w$latitude,
            label = w$language)
wals.feature(c('1a', '2a')) -> w
map.feature(language = w$language, # vowel inventory
            features = w$`2a`,
            longitude = w$longitude,
            latitude = w$latitude,
            label = w$language)
    # autotyp
a <- autotyp.feature(c('Gender', 'Numeral classifiers')) # don't forget to cite things properly!
a %>% 
  select(language, Gender.n) %>% 
  na.omit() -> a2

map.feature(languages = a2$language,
            features = a2$Gender.n,
            label = a2$language)

a_big <- autotyp.feature(c('Gender', 'Numeral classifiers'), na.rm = FALSE) # don't throw away those languages that are absent in lingtypology package
