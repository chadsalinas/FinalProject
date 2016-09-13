#  Chad Salinas
#  9/11/2016
#  Data Cleaning Final Project
#  The input for the script is raw data
#  The output is the processed, tidy data
#  There are no parameters to the script

setwd("~/Documents/JohnsHopkinsData/DataCleaning")

if (!file.exists("data")) {
        dir.create("data")
}

library(data.table)
library(dplyr)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
#dateDownloaded <- date()
#print(dateDownloaded)
#unzip("./data/Dataset.zip", exdir = "./data")
print(list.files("./data/UCI HAR Dataset"))
traindata <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
testdata <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")

#dim(traindata) should have 7352 rows and 561 cols 
#dim(testdata) should have 2947 rows and 561 cols
#Columns matching means I can join, so choice is full outer join or inner join.  
#Inner join requires a matching variable(key) but here 30 subjects were exclusively partioned into either test or train.  

# Merge the training data and test data using full outer 
mergedData = merge(traindata, testdata, all=TRUE)

# Need to read feature labels to give descrptive names to the interesting mean() and std() subset of 561 columns
features <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE)

# Filter out the non-mean and non-std rows in the features
features <- features[grep("mean|Mean|std", features$V2), ]

# Tack a "V" on the front of the first column of features so it matches the non-intuitive column names in data files
features$V1 <- sub("^", "V", features$V1)

# Give meaningful names to the columns in train and test data, yields NA for all other column names
names(mergedData) <- features$V2[match(names(mergedData), features$V1)]

# Select only columns with Mean() or Std() measures, by getting rid of all NA columns 
mergedData <- mergedData[!is.na(names(mergedData))]

# Train subjects' activity ids can be found in y_train.txt which has 7352 rows & 1 col matching the train data
# Test subjects' activity ids can be found in y_test.txt which has 2947 rows & 1 col matching the test data
trainActivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header=FALSE)
testActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header=FALSE)

# Rename V1 as Activity 
names(trainActivity) <- "Activity"
names(testActivity) <- "Activity"

# Merge the Activity IDs
mergedActivity <- rbind(trainActivity, testActivity)

# Need to read activity labels to correlate 6 activities to their numbers
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE)

# Replace Activity ID with 1 of 6 corresponding descriptive Activity Labels
mergedActivity[["Activity"]] <- activities[ match(mergedActivity[['Activity']], activities[['V1']] ) , 'V2']

# Append Activity Label column to dataset
mergedData <- cbind(mergedActivity$Activity , mergedData)

# Train subjects data can be found in subject_train.txt which has 7352 rows & 1 col matching the train data
# Test subjects data can be found in subject_test.txt which has 2947 rows & 1 col matching the test data
trainsubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
testsubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

# Rename V1 as SubjectId 
names(trainsubjects) <- "SubjectId"
names(testsubjects) <- "SubjectId"

# Merge the training subjects' ids and test subjects' ids
mergedSubjectIds = merge(trainsubjects, testsubjects, all=TRUE)

# Need to append the subject ids column to the dataset
mergedData <- cbind(mergedSubjectIds$SubjectId , mergedData)

# Give descriptive variable names
names(mergedData)[1] <- "SubjectID"
names(mergedData)[2] <- "Activity"

#cleanup
rm(traindata, testdata, activities, features, trainActivity, testActivity, mergedActivity, trainsubjects, testsubjects, mergedSubjectIds)
write.table(mergedData, file = "./data/mergedData.csv", row.names=FALSE, sep=",")

# 5 Create a 2nd tidy data set with avg of each var for each activity and each subject
library(reshape2)
library(plyr)
meltedData <- melt(mergedData, id.vars=c("SubjectID", "Activity"))
# Summarised data should be the mean of 30 subjects X 6 activities X 86 measures
meltedMean <- ddply(meltedData, c("SubjectID", "Activity", "variable"), summarise, mean = mean(value))
write.table(meltedMean, file = "./data/meltedMean.csv", row.names=FALSE, sep=",")

