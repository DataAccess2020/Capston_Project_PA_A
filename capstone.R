
library(tidyverse)
library(dplyr)
library(ggplot2)
library(httr)
library(curl)
library(tidyr)
library(RCurl)
library(jsonlite)
library(stringi)
library(stringr)
library(readr)
library(rvest)


dict <- rvest::read_html(x="https://www.epa.gov/green-power-markets/glossary") %>%
  html_elements(css="dt strong")%>%
  html_text()
dict

dict1 <-  rvest::read_html(x="https://www.dictionary.com/e/climate-change-terms/#glossary-of-terms") %>%
  html_elements(css="strong")%>%
  html_text()
dict1


mw <- c("net/zero","decarbonisation/pathway", "carbon/positive", "carbon/negative", "climate/crysis", "climate/justice" )
mw

topic <- data.frame(words=c(dict,mw))
topic


url <- "https://api.propublica.org/congress/v1/bills/subjects/"

links1 <- as.data.frame(stri_paste(url,topic$words,".json"))
links1

i <- 1
for (i in 1:nrow(links1)){
  links1$key <- c(key)
}

i <- 1
for(i in 1:nrow(links1)){
result <- RCurl::getURL(links1$`stri_paste(words,".json")`,
                          httpheader = c(links1$key))
  Sys.sleep(1)
  cat(result)
}


