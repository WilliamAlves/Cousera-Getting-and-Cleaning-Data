#########################################################################
# ************** Getting and Cleaning Data Course Project ***************
#########################################################################

library(dplyr)

### Get the data

zipFile <- "getdata_projectfiles_UCI HAR Dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFolder <- "UCI HAR Dataset"

# Checks if the zip file already exists
if (!file.exists(zipFile)){ 
  # Download the zip file containing the data, if  it doesn't exists 
  download.file(fileURL, zipFile, method="curl")
}  

# Checks if the folder with the data already exists
if (!file.exists(dataFolder)) { 
  # Extract the folder from the zip file, if it doesn't
  unzip(zipfile) 
}

### Load the data

# Features
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

# Activities
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Test Data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
testValues <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
testActivity <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Trainig Data
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
trainValues <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
trainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

### 1 - Merges the training and the test sets to create one data set
Values <- rbind(trainValues, testValues)
Activity <- rbind(trainActivity, testActivity)
Subject <- rbind(trainSubject, testSubject)
merged <- cbind(Subject, Activity, Values)

### 2 - Extracts only the measurements on the mean 
###     and standard deviation for each measurement
mergedData <- merged %>% select(subject, code, contains("mean"), contains("std"))

### 3 - Uses descriptive activity names to name the activities in the data set
mergedData$code <- activities[mergedData$code, 2]

### 4 - Appropriately labels the data set with descriptive variable names
names(mergedData)[2] = "activity"
names(mergedData)<-gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData)<-gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData)<-gsub("BodyBody", "Body", names(mergedData))
names(mergedData)<-gsub("Mag", "Magnitude", names(mergedData))
names(mergedData)<-gsub("^t", "Time", names(mergedData))
names(mergedData)<-gsub("^f", "Frequency", names(mergedData))
names(mergedData)<-gsub("tBody", "TimeBody", names(mergedData))
names(mergedData)<-gsub("angle", "Angle", names(mergedData))
names(mergedData)<-gsub("gravity", "Gravity", names(mergedData))
names(mergedData)<-gsub("-mean()", "Mean", names(mergedData), ignore.case = TRUE)
names(mergedData)<-gsub("-std()", "STD", names(mergedData), ignore.case = TRUE)
names(mergedData)<-gsub("-freq()", "Frequency", names(mergedData), ignore.case = TRUE)

### 5 - From the data set in step 4, creates a second, 
###     independent tidy data set with the average of each variable
###     for each activity and each subject
tidyData <- mergedData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

### Writes the result in a file
write.table(tidyData, "TidyData.txt", row.name=FALSE)


