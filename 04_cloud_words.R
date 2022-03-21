#cloud words

b_stit<- import("stitle.csv")

stop_words
typeof(b_stit$title)
colnames(b_stit) <- c("empty", "title", "id")
b_stit$title <- as.character(b_stit$title)

b_stit$title <- removeNumbers(b_stit$title)



titlew<- b_stit %>% 
  select(title, id) %>% 
  unnest_tokens(split_titlew, title, token="ngrams", n=1)


filtertit<- titlew %>% 
  filter(!split_titlew %in% stop_words$word) %>% 
  filter(!split_titlew %in% stop_words$word)



words_count <- filtertit %>%
  count(split_titlew)
words_count

wordcloud2(words_count, size = 1.6, 15)