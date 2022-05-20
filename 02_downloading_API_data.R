#downloading data from Propublica API
query <- import("links3.csv")


s_query <- as.data.frame  (query$key[1:3])
s_query$link <- c("https://api.propublica.org/congress/v1/bills/search.json?query=climate%20change",
                  "https://api.propublica.org/congress/v1/bills/search.json?query=carbon%20emissions",
                  "https://api.propublica.org/congress/v1/bills/search.json?query=sea%20level%20rise")

colnames(s_query) <- c("key", "que_link")


v_off <- seq(0,2000, by = 20)
q_offset <- as.character(v_off)

result <- vector(mode = "list")

i <-  0
for (i in 1:length(q_offset)){ 
  step <- RCurl::getURL(
                        paste0(s_query$que_link[1], "&","offset=", q_offset[i]),
                               httpheader = c(s_query$key[1]))
  result <- append(result, step)
  Sys.sleep(1)
  cat(q_offset[i]," ")
}

result1 <- vector(mode = "list")
i <-  0
for (i in 1:length(q_offset)){ 
  step <- RCurl::getURL(
                        paste0(s_query$que_link[2], "&","offset=", q_offset[i]),
                         httpheader = c(s_query$key[2]))
  result1 <- append(result1, step)
  Sys.sleep(1)
  cat(q_offset[i]," ")
}

result2 <- vector(mode = "list")
i <-  0
for (i in 1:length(q_offset)){ 
  step <- RCurl::getURL(
                         paste0(s_query$que_link[3], "&","offset=", q_offset[i]),
                         httpheader = c(s_query$key[3]))
  result2 <- append(result2, step)
  Sys.sleep(1)
  cat(q_offset[i]," ")
}

d_api<- c(result,result1,result2)

r_list <- list()

i <- 1
for (i in 1:length(d_api)){
  step <- fromJSON(d_api[[i]])
  r_list[[length(r_list)+1]] <- step
}

