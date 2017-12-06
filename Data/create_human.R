#Kevin Sandeman Data wrangling human file from the United Nations Development Programme (RStudio Exercise 5)

# Comment: To be sure that I'm still working with the right material i started from the link in RStudio Excercise chapter 5.

# 1. Read file and check variables
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep =",")
names(human)
str(human)
summary(human)

# Do string manipulation and mutate GNI to numeric
library(stringr)
library(dplyr)

# remove the commas from GNI and print out a numeric version of it
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
names(human)

# 2. columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# 3. filter out all rows with NA values
human <- filter(human, complete.cases(human))

#  look at the last 10 observations of human
tail(human, 10)

# define the last indice we want to keep
last <- nrow(human) - 7

# 4. choose everything until the last 7 observations
human <- human[1:last, ]
human
# 5. add countries as rownames and overwrite old file
#Save data and check data

setwd("C:/Users/kevin/Dropbox/IODScourse/IODS-project/Data")
write.csv(file = "human.csv", row.names = TRUE)
read.csv("human.csv", header = TRUE, row.names = 1)
