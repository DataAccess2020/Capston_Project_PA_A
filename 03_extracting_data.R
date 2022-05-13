# extracting from the registers

sub_list <- list()
i <- 1
for (i in 1:length(r_list)){
  step <- r_list[[i]][[3]][[1]][[3]]
  sub_list[[length(sub_list)+1]] <- step
}

sub_list[c(183:202)]= NULL

# extract bills id

id <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[1]]
    id[[length(id)+1]] <- step
  }
}

# extract sponsor state
s_s <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[11]]
    s_s[[length(s_s)+1]] <- step
  }
}

# extract sponsor party
sp_p <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[12]]
    sp_p[[length(sp_p)+1]] <- step
  }
}

#extract introduced date

i_date <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[17]]
    i_date[[length(i_date)+1]] <- step
  }
}

# extracty title

tit <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[6]]
    tit[[length(tit)+1]] <- step
  }
}



# id senator who sponsored the bills 
sen_id <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[9]]
    sen_id[[length(sen_id)+1]] <- step
  }
}

# primary subject

prim_subj <- list()
i <- 0
j <- 0
for(i in 1:length(sub_list)){
  for(j in 1:20){
    step <- sub_list[[i]][[j]][[29]]
    prim_subj[[length(prim_subj)+1]] <- step
  }
}



id <- as.data.frame(do.call(rbind, id))
s_s <- as.data.frame(do.call(rbind, s_s))
sp_p <- as.data.frame(do.call(rbind, sp_p))
i_date  <- as.data.frame(do.call(rbind, i_date))
tit <- as.data.frame(do.call(rbind, tit))
sen_id <- as.data.frame(do.call(rbind, sen_id))
prim_subj <- as.data.frame(do.call(rbind, prim_subj))



DF <- NULL
DF <- data.frame(id, s_s, sp_p, i_date, sen_id, prim_subj, tit)

colnames(DF) <- c("BILLS_id","sp_STATE","sp_PARTY","PROMULGATE","SEN_id","p_SUBJECT","TITLE")

write.csv(DF, "data_from_api.csv")





