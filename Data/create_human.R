#Read the "Human development" and "Gender inequality" datas into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#Structure, dimensions and summaries of the variables
dim(hd)
str(hd)
summary(hd)
dim(gii)
str(gii)
summary(gii)


#New columnnames
colnames(hd) <- c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")
colnames(gii) <- c("GII.Rank", "Country","GII", "Mat.Mort", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

#New variable ratio of Female and Male populations with secondary education and ratio of labour force participation of females and males
gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M
library(dplyr)
human <- inner_join(hd, gii, by = "Country")
str(human)

#Save data
setwd("C:/Users/kevin/Dropbox/IODScourse/IODS-project/Data")
write.csv(human, file = "human.csv", row.names = FALSE)