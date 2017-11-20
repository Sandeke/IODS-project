# create_alc.R : Step 1-2 done
# 3.Read both student-mat.csv and student-por.csv into R; check structure and dimensions

math <- read.table("C:/Users/kevin/Dropbox/IODScourse/IODS-project/Data/student-mat.csv"
, sep = ";", header=TRUE)

por <- read.table("C:/Users/kevin/Dropbox/IODScourse/IODS-project/Data/student-por.csv", sep = ";", header = TRUE)

dim(math)
str(math)
dim(por)
str(por)

# 4.Join the two data sets, keep students present in both sets and explore the structure and dimensions of the joined data
library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix= c(".math", ".por"))
dim(math_por)
str(math_por)

#5a. Combine duplicated answers.

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# 6. Take the average of the answers related to weekday and weekend alcohol consumption to create a new column 'alc_use'. 
# Use 'alc_use' to create a new logical column 'high_use'.
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# 7. check data and write table.
glimpse(alc)
setwd("C:/Users/kevin/Dropbox/IODScourse/IODS-project/Data")
write.csv(alc, file = "alc.csv", row.names = FALSE)
