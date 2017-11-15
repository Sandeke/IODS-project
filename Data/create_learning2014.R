# Author: Kevin Sandeman
# Date: 10.11.2017
# File description: datawrangling of learning2014data.

data_url <- "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"
lrn14 <- read.table(data_url, sep="\t", header = TRUE)

dim(lrn14)
#183 entries of 60 variables 

str(lrn14)
# All variables are integer except for gender

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Access the dplyr library
library(dplyr)

# select the columns related to deep, surface and strategic learning and create column 'deep, surf and stra' by averaging

deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# Create a new dataset and select rows where points is greater than zero
learning2014 <- select(lrn14, one_of(keep_columns))
learning2014 <- filter(learning2014, Points > 0)

# Controle
str(learning2014)

# Working directory
setwd("C:\\Users\\kevin\\Dropbox\\IODScourse\\IODS-project\\Data")

# Save dataset
write.csv(learning2014, file = "learning2014.csv", row.names = FALSE)
read.csv(file="learning2014.csv", header=TRUE, sep=",")

#Control
str(learning2014)
head(learning2014)
