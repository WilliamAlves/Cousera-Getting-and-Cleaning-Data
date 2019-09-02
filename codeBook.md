# Code Book

### Download files and reading the data

* dataFolder <- The name of the folder where the data is store (“"UCI HAR Dataset"”)
* fileURL <- Address to download the files
* zipFile <- The name of the zip file downloaded from the web ("getdata_projectfiles_UCI HAR Dataset.zip")
* features <- reads “features.txt”,  a list of all features with 561 rows and 2 columns.
* activities <- reads “activity_labels.txt”, that links the class labels with their activity name. 6 rows, 2 columns.
* testSubject <- reads “test/subject_test.txt”, with 2947 rows and 1 column. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* testValues <- “test/X_test.txt”, test set. 2947 rows, 561 columns. 
* testActivity <- “test/y_test.txt”, test labels. 2947 rows, 1 columns.
* trainSubject <- “train/subject_train.txt”, with 7352 rows and 1 column. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* trainValues <-  “train/X_train.txt”, training set. 7352 rows, 561 columns.
* trainActivity <- “train/y_train.txt”, training labels. 7352 rows, 1 columns. 

### Data merging

* Values <- rbind(trainValues, testValues). 10299 rows, 561 columns.
* Activity <- rbind(trainActivity, testActivity). 10299 rows, 1 column.
* Subject <- rbind(trainSubject, testSubject). 10299 rows, 1 column.
* merged <- cbind(Subject, Activity, Values). 10299 rows, 563 column.

### Change labels to be more descriptive 

To label the data with descriptive names, we use ‘gsub()’ to substitute: 
* “Acc" for "Accelerometer"
* “Gyro" for "Gyroscope"
* "BodyBody" for "Body"
* "Mag" for "Magnitude"
* "^t", for”Time"
* "^f" for "Frequency"
* "tBody" for "TimeBody"
* "angle" for "Angle"
* "gravity" for "Gravity"
* "-mean()" for "Mean"
* "-std()" for "STD"
* “-freq()" for "Frequency"

### Mean and Standard deviation 

merdedData <- subset ‘merged’, selecting the ‘subject’, ‘code’ and measuring the mean and standard deviation for each row. 10299 rows, 88 columns.

### Dataset with average of each variable

tidyData <- The final, organised and summarized data. Groups by subject and activity, and then takes the mean of each variable for activity and subject. 180 rows, 88 columns.
