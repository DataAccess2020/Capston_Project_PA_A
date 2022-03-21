# extracting from the registers

sponsor_list <- list()
i <- 1
for (i in 1:100){
  step <- bills_list[[i]][[3]][[1]][[3]]
  sponsor_list[[length(sponsor_list)+1]] <- step
}

try <- list()

for(i in 1:100){
  for(j in 1:20){
    step <- sponsor_list[[i]][[j]][[25]]
    try[[length(try)+1]] <- step
  }
}

party <- as.data.frame(do.call(rbind, try))

id <- (1:1650)
party$id <-  id 



pol_par<- as.data.frame(rep)
pol_par$dem <- as.data.frame(dem)

ggplot(pol_par, aes(x=pol_par)) +
  geom_bar(stat = "identity") +
  ggtitle("who sign more bill against climate changes") +
  theme_bw()






dat <- list()
i <- 1
j <- 1
for(i in 1:100){
  for(j in 1:20){
    step <- sponsor_list[[i]][[j]][[17]]
    dat[[length(dat)+1]] <- step
  }
}

promulgate <- as.data.frame(do.call(rbind, dat))
id <- (1:2000)
promulgate$id <-  id 

tit <- list()
i <- 1
j <- 1
for(i in 1:100){
  for(j in 1:20){
    step <- sponsor_list[[i]][[j]][[7]]
    tit[[length(tit)+1]] <- step
  }
}

s_title <- as.data.frame(do.call(rbind, tit))
id <- (1:2000)
s_title$id <-  id 



PS <- list()
i <- 1
j <- 1
for(i in 1:100){
  for(j in 1:20){
    step <- sponsor_list[[i]][[j]][[12]]
    PS[[length(PS)+1]] <- step
  }
}



spo_par <- as.data.frame(do.call(rbind, PS))
id <- (1:2000)
spo_par$id <-  id 

party$R <- as.numeric(party$R)
party$D <- as.numeric(party$D)
rep <- sum(party$R)
dem <- sum(party$D)

write.csv(party, "party.csv")
write.csv(promulgate, "promulgate.csv")
write.csv(s_title, "stitle.csv")
write.csv(spo_par, "sponsor_party.csv")
write.csv(pol_par, "pp.csv")