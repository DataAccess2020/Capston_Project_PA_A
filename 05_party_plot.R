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
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(n, "%")), position = position_stack(vjust=0.5), col = "white") +
  labs(x = NULL, y = NULL, fill = NULL) +
  theme_classic() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())+
  scale_fill_manual(values=c("#104E8B", "#75FF33", "#8B1A1A"))+
  ggtitle("Which party promote more bills\nabout environment")

# date of promulgation

date_gr <- api_d %>%
  group_by(BILLS_id,PROMULGATE) %>%
  count() %>%
  ungroup()


ggplot(date_gr, aes(x=PROMULGATE, fill=as.factor(PROMULGATE) )) +  
  geom_bar(x) +
  theme(legend.position="none")

# state who prpposed more bills about climate changes 

state_gr <- api_d %>%
  group_by(BILLS_id,sp_STATE) %>%
  count() %>%
  ungroup()

usa<- map_data('state')

ggplot(state_gr, aes(x=long,y=lat,group=group, fill=count))+
  geom_polygon(color='gray')+
  coord_map('polyconic')+
  scale_fill_gradient2(low= "white", high= "red")
                       
