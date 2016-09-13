Chad Salinas
Data Cleaning Final Project
9/11/2016
README.md

Study Design _ Info about the experimental study design I used
The original study divided 30 subjects aged 19-48 performing 1 of 6 above activities. 70% of partcipants performed train data, while remaining
30% performed test data.

The Instruction List - to get tidy data, I did the following in a script named run_analysis.R
Download "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Record download date
Unzip the file
Read the train data
Read the test data
Confirm train data should have 7352 rows and 561 cols 
Confirm test data should have 2947 rows and 561 cols
Merge using full outer join as these 30 subjects were exclusively partioned into either test or train.  
Read feature labels to give descrptive names to the interesting mean() and std() subset of 561 columns
Filter out the non-mean and non-std rows in the features
Give meaningful names to the columns in train and test data, yields NA for all other column names
Select only columns with Mean() or Std() measures, by getting rid of all NA columns 
Read Train subjects' activity ids from in y_train.txt which has 7352 rows & 1 col matching the train data
Read Test subjects' activity ids from in y_test.txt which has 2947 rows & 1 col matching the test data
Rename V1 as Activity 
Merge the Activity IDs
Read activity labels to correlate 6 activities to their numbers
Replace Activity ID with 1 of 6 corresponding descriptive Activity Labels
Append Activity Label column to dataset
Read Train subjects data from subject_train.txt which has 7352 rows & 1 col matching the train data
Read Test subjects data from subject_test.txt which has 2947 rows & 1 col matching the test data
Rename V1 as SubjectId 
Merge the training subjects' ids and test subjects' ids
Need to append the subject ids column to the dataset
Give descriptive variable names


For Part #5 - Create a 2nd tidy data set with avg of each var for each activity and each subject
Use reshape2 and plyr libraries to melt the above mergedData on "SubjectID" and "Activity"
Summarised data should be the mean of 30 subjects X 6 activities X 86 measures = to 15,480 observations in meltedData


