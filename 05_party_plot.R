# plots which party promote more bills against climate changing 

sum_cos<- import("pp.csv")
spo_part<- import("sponsor_party.csv")
i_date<- import("promulgate.csv")

plot1 <- data.frame(
  party= c("rep", "dem"),
  value= c(18175, 28525)
)

ggplot(plot1, aes(x=party,y= value)) +
  geom_bar(stat= "identity")+
  theme()

colnames(spo_part) <- c("empty", "party", "id")


spo_part <- spo_part %>%
  group_by(party)%>%
  count()

ggplot(spo_part, aes(x=party,y= n)) +
  geom_bar(stat= "identity")+
  theme()


colnames(i_date) <- c("empty", "date", "id")


i_date <- i_date%>%
  group_by(date)%>%
  count()

ggplot(i_date, aes(x=date, y= n)) +
  geom_line() +
  theme_bw()







