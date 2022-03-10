
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
topic$words <- str_replace_all(topic$words,pattern="[\\s]","")
topic$words <- str_replace(topic$words, pattern = "\"","")
topic$words <- str_replace(topic$words, pattern =":","")
topic$words <- str_replace(topic$words,pattern ="[(]","")
topic$words <- str_replace(topic$words,pattern ="[)]","")
topic$words <- str_replace(topic$words,pattern ="🔑&Key&message&0about&language&use","")
topic$words <- str_replace(topic$words,pattern ="Biodiversity","")
topic$words <- str_replace(topic$words,pattern ="Glossary&of&terms","")
topic$words <- str_replace(topic$words,pattern ="Executive&Order&EO%2013693","")
topic$words <- str_replace(topic$words,pattern ="Community&Choice&Aggregation&CCA","")
topic$words <- str_replace(topic$words,pattern ="Weather&vs.&climate","")
topic$words <- str_replace(topic$words,pattern ="carbon&dioxide&and&related&terms","")
topic$words <- str_replace(topic$words,pattern ="Additionality","")
topic$words <- str_replace(topic$words,pattern ="-","&")
typeof(topic)
topic <- data.frame(topic)
topic <- topic[!apply(topic == "", 1, all), ]
topic <- data.frame(topic)
topic


#api                #           #

api_link <- "https://api.propublica.org/congress/v1/bills/subjects/"

links1 <- as.data.frame(stri_paste(api_link,topic$words,".json"))
links1

links1 <- as.data.frame(1:75)

i <- 1
for (i in 1:75){
  links1$key <- c(key)
}


link <- as.vector(stri_paste(api_link,topic,".json"))
link

new <- as.vector("xxxx")

i <- 1
for(i in 1:74){
  new <- append(new,(stri_paste(api_link,topic[i, 1],".json")))
}

links1$links <- new


links1 <- links1[-c(1), ]

i <- 1
for(i in 1:nrow(links)){
  result <- RCurl::getURL(links1$links,
                          httpheader = c(links1$key))
  cat(result)
  Sys.sleep(1)
}





