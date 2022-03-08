
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

#email <- "paolo.amantini@studenti.unimi.it"
#user_agent <- R.Version()$version.string


dict <- rvest::read_html(x="https://www.epa.gov/green-power-markets/glossary") %>%
  html_elements(css="dt strong")%>%
  html_text()
dict

str_trim(dict)
str_replace(dict, pattern= "\\s*","%20")
str_replace(dict,pattern="\\s","%20")


dict1 <-  rvest::read_html(x="https://www.dictionary.com/e/climate-change-terms/#glossary-of-terms") %>%
  html_elements(css="strong")%>%
  html_text()
dict1



topic <- data.frame(words=c(dict,dict1))
topic

str_trim(topic$words)
str_replace(topic$words, pattern= "[\\s]*","%20")

str_view_all(topic, pattern = "/s")
  
  
  
  green/power/purchasing

#api                #           #

api_link <- "https://api.propublica.org/congress/v1/bills/subjects/climate/change.json"

links1 <- as.data.frame(stri_paste(api_link,topic$words,".json"))
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

api_link <- "https://api.propublica.org/congress/v1/bills/subjects/climate%20change.json"
query <- "https://api.propublica.org/congress/v1/bills/search.json?query=climate%20change"

clima <- RCurl::getURL(query,
                       httpheader = key)
clima .
clima
clima[]
