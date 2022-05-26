# plots which party promote more bills against climate changing 

api_d <- import("data_from_api.csv")

party_gr <- api_d %>%
  group_by(BILLS_id,sp_PARTY) %>%
  count() %>%
  ungroup()

party_gr$n <- ifelse(party_gr$n== 1, "1", "1") 

party_gr1 <- party_gr %>%
  group_by(sp_PARTY,n) %>%
  count() %>%
  ungroup()

perc <- (party_gr1$nn/length(party_gr$BILLS_id)*100)
party_gr1$n <-c(perc)
party_gr1$n<- round(party_gr1$n, 2)

ggplot(party_gr1, aes(x="", y=nn, fill=sp_PARTY)) +
  geom_bar(stat="identity", width=1, col="white", alpha= .9) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(n, "%")), position = position_stack(vjust=0.5), col = "black") +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_classic() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  scale_fill_manual(values=c("#1874CD", "#76EE00", "#CD2626"))+
  ggtitle("Which party promotes more bills\nabout environment")

# date of promulgation

date_gr <- api_d %>%
  group_by(BILLS_id,PROMULGATE) %>%
  count() %>%
  ungroup()

gr_dat<- date_gr %>% 
  group_by(year = lubridate::floor_date(PROMULGATE, "year")) %>%
  count()%>%
  ungroup()


ggplot(gr_dat, aes(x=year,y=n, col=as.factor(year))) +  
  geom_point() +
  ylab("number of bills")+
  theme(legend.position="none") 


# state who prpposed more bills about climate changes 

state_gr <- api_d %>%
  group_by(sp_STATE,BILLS_id) %>%
  count() %>%
  ungroup()

state_gr$sp_STATE <- state.name[match(state_gr$sp_STATE,state.abb)]
state_gr$sp_STATE<- tolower(state_gr$sp_STATE)

b_stat <- state_gr %>%
  group_by(sp_STATE) %>%
  count() %>%
  ungroup()

#b_stat<- b_stat[-c(51),]
colnames(b_stat) <- c("state","n")

plot_usmap(data = b_stat, values = "n" ,  color = "black", ) + 
  scale_fill_continuous(low = "white", high = "darkgreen", name = "number of bils promoted", label = scales::comma) + 
  labs(title = "bills promoted by states") +
  theme(legend.position = "none")

# P_subjects

sj <- api_d %>%
  group_by(BILLS_id, p_SUBJECT) %>%
  count() %>%
  ungroup()

sbj <- sj%>%
  group_by (p_SUBJECT) %>%
  count() %>%
  ungroup()

sbj <-sbj[sbj$n > 188, ]

ggplot(sbj, aes(x= reorder(p_SUBJECT, -n), y = n,fill=as.factor(p_SUBJECT))) +
  geom_bar(stat = "identity") +
  theme(legend.position = "none")+
  theme(axis.text.x=element_text(angle= 20,hjust=1)) +
  xlab("subject")+
  ylab("number of bills")

# senator

se <- api_d %>%
  group_by(BILLS_id,SEN_id) %>%
  count() %>%
  ungroup()

sen <- se%>%
  group_by (SEN_id) %>%
  count() %>%
  ungroup()

sen <-sen[sen$n > 34, ]

ggplot(sen, aes(x= reorder(SEN_id, -n), y = n,fill=as.factor(SEN_id))) +
  geom_bar(stat = "identity") +
  theme(legend.position = "none")+
  theme(axis.text.x=element_text(angle= 5,hjust=1)) +
  xlab("senator id") +
  ylab("number of bills promoted")
  