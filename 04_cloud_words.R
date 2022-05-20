#cloud words

api_d <- import("data_from_api.csv")

stop_words
typeof(api_d$TITLE)
colnames(b_stit) <- c("empty", "title", "id")

api_d$TITLE <- removeNumbers(api_d$TITLE)



titlew<- api_d %>% 
  select(TITLE, BILLS_id) %>% 
  unnest_tokens(split_titlew, TITLE, token="ngrams", n=1)


filtertit<- titlew %>% 
  filter(!split_titlew %in% stop_words$word) %>% 
  filter(!split_titlew %in% stop_words$word)



words_count <- filtertit %>%
  count(split_titlew)
words_count

wordcloud2(words_count, size = 1.6, 15)
