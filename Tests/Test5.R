
gutenberg_metadata %>% 
  filter(has_text) %>% 
  count(author) %>% 
  filter(author == c(filter(gutenberg_authors, birthdate == min(na.omit(gutenberg_authors$birthdate)))['author']))

gutenberg_works() %>% 
  filter(author == '')

carrol <- gutenberg_download(gutenberg_id = slice(gutenberg_works(), grep('Carrol', author))['gutenberg_id'])
carrol <- gutenberg_download(c(11, 12))
carrol %>% 
  unnest_tokens(word, text) -> tidy_carrol

w <- data.frame(word = c('he', 'she'))
tidy_carrol %>% 
  count(word, gutenberg_id) %>% 
  inner_join(w) %>% 
  ggplot(aes(word, n))+
  geom_col()+
  coord_flip()+
  facet_wrap(~gutenberg_id, scales = 'free')

wals.feature("30A") -> w
autotyp.feature("Gender") -> a 
colnames(w)[2] <- "Gender.n"
w %>% 
  mutate(Gender.n = case_when(Gender.n == 'None' ~ '0',
                              Gender.n == 'One' ~ '1',
                              Gender.n == 'Two' ~ '2',
                              Gender.n == 'Three' ~ '3',
                              Gender.n == 'Four' ~ '4',
                              Gender.n == 'Five or more' ~ '>4')) -> w

a %>% 
  mutate(Gender.n = ifelse(Gender.n > 4, '>4', Gender.n)) %>% 
  mutate(Gender.Presence = case_when(!is.na(Gender.n) ~ TRUE
                                     Gender.Presence == FALSE ~ '0')) -> a
w <- na.omit(w)
a <- na.omit(a)
m <- inner_join(a, w, by = 'language')

m %>% 
  mutate(Dif = ifelse(Gender.n.x == Gender.n.y, 1, 0)) -> m

1 - sum(m['Dif'])/count(m['Dif'])
