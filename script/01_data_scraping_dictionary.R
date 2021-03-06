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
library(rio)
library(SPARQL)
library(XML)
library(tm)
library(rjson)
library(lubridate)
library(tidytext)
library(wordcloud2)
library(ggmap)
library(htmltools)
library(maps)
library(mapproj)
library(mapdata)
library(usmap)

email <- "paolo.amantini@studenti.unimi.it"
user_agent <- R.Version()$version.string

f_url <- "https://www.epa.gov/green-power-markets/glossary"
s_url <- "https://www.dictionary.com/e/climate-change-terms/#glossary-of-terms"

dict <- httr::GET(url= f_url,
                  
                  add_headers(
                    
                    From= email,
                    
                    `User-Agent`= R.Version()$version.string
                    
                  )
                  
) %>%
  rvest::read_html() %>%
  html_elements(css="dt strong")%>%
  html_text()


dict1 <- httr::GET(url= s_url,
                   
                   add_headers(
                     
                     From= email,
                     
                     `User-Agent`= R.Version()$version.string
                     
                   )
                   
) %>%
  rvest::read_html() %>%
  html_elements(css="strong")%>%
  html_text()
dict1


topic <- data.frame(words=c(dict,dict1))
topic

topic$words <- str_trim(topic$words)
topic$words <- str_replace_all(topic$words,pattern="[\\s]","%20")
topic$words <- str_replace_all(topic$words, pattern = "\"","")
topic$words <- str_replace(topic$words, pattern =":","")
topic$words <- str_replace(topic$words,pattern ="[(]","")
topic$words <- str_replace(topic$words,pattern ="[)]","")
topic$words <- str_replace(topic$words,pattern ="🔑%20Key%20message%20about%20language%20use","")
topic$words <- str_replace(topic$words,pattern ="Biodiversity","")
topic$words <- str_replace(topic$words,pattern ="Glossary%20of%20terms","")
topic$words <- str_replace(topic$words,pattern ="Executive%20Order%20EO%2013693","")
topic$words <- str_replace(topic$words,pattern ="Community%20Choice%20Aggregation%20CCA","")
topic$words <- str_replace(topic$words,pattern ="Weather%20vs.%20climate","")
topic$words <- str_replace(topic$words,pattern ="carbon%20dioxide%20and&related%20terms","")
topic$words <- str_replace(topic$words,pattern ="Additionality","")
topic$words <- str_replace(topic$words,pattern ="-","%20")
topic$words <- str_replace(topic$words,pattern ="carbon%20dioxide%20and%20related%20terms","")
topic$words <- str_replace(topic$words,pattern ="GWP%20Global%20Warming%20Potential","")
topic$words <- str_replace(topic$words,pattern ="EV%20electric%20vehicle","")
topic$words <- str_replace(topic$words,pattern ="climate%20and%20related%20terms","")
topic$words <- str_replace(topic$words,pattern ="Utility","")
topic$words <- str_replace(topic$words,pattern ="Vintage","")
topic$words <- str_replace(topic$words,pattern ="Unbundled","")
topic$words <- str_replace(topic$words,pattern ="Short%20Ton","")
topic$words <- str_replace(topic$words,pattern ="retail%20competition","")

typeof(topic)
topic <- data.frame(topic)
topic <- topic[!apply(topic == "", 1, all), ]
topic <- data.frame(topic)
topic


q_link <- "https://api.propublica.org/congress/v1/bills/search.json?query="

links2 <- as.data.frame(stri_paste(q_link,topic$words))
links2 <- as.data.frame(1:68)

i <- 1
for (i in 1:68){
  links2$key <- c(key)
}

r_link <- as.vector(stri_paste(q_link,topic))
r_link

vec <- as.vector("xxxx")

i <- 1
for(i in 1:67){
  vec <- append(vec,(stri_paste(q_link,topic[i, 1])))
}

links2$r_link <- vec

links2 <- links2[-c(1), ]

write.csv(links2, "links3.csv")



