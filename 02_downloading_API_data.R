#downloading data from Propublica API
query<- import("links3.csv")


s_query <- as.data.frame  (query$key[1:3])
s_query$link <- c("https://api.propublica.org/congress/v1/bills/search.json?query=climate%20change",
                  "https://api.propublica.org/congress/v1/bills/search.json?query=carbon%20emissions",
                  "https://api.propublica.org/congress/v1/bills/search.json?query= sea%20level%20rise")

colnames(s_query) <- c("key", "que_link")


q_offset <- c( "0","20", "40", "60","80","100","120","140","160","180","200",
               "220","240","260", "280","300","320","340","360","380","400",
               "420","440","460","480","500","520","540","560","580","600",
               "620","640","660","680","700","720","740","760","780","800",
               "820","840", "860","880","900","920","940","960","980")

result <- vector(mode = "list")

i= 0
for (i in 1:length(q_offset)){ 
  step <- RCurl::getURL(paste0(s_query$que_link, ",","offset=", q_offset[i]),
                        httpheader = c(s_query$key))
  result <- append.xmlNode(result, step)
  Sys.sleep(1)
  cat(q_offset[i]," ")
}


del <- seq(0,150, by = 3)
prov<- result[-c(del)]

bills_list <- list()

i <- 1
for (i in 1:100){
  step <- fromJSON(prov[[i]])
  bills_list[[length(bills_list)+1]] <- step
}

