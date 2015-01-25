##You should create one R script called run_analysis.R that does the following.
##1. Merges the training and the test sets to create one dataset.
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
##3. Uses descriptive activity names to name the activities in the dataset
##4. Appropriately labels the dataset with descriptive variable names.
##5. From the dataset in step4, create a second, independent tidy dataset with the average of each
##   variable for each activity and each subject.

## Basic checking for existance of data files
## dir.exist is not a supported function, so we are checking whether features.txt
## is available inside the dataset directory in current working directory

if(!file.exists("dataset/features.txt"))
  stop("Dataset is unavailable! Pls put the dataset in the same directory along with this script and name the directory as dataset")

## Read the features text in the variable named "feat"
feat <- read.table("dataset/features.txt")

## Read the activity_labels text in the variable named "act"
act <- read.table("dataset/activity_labels.txt")

## Read the test data
test.sub <- read.table("dataset/test/subject_test.txt")
test.x <- read.table("dataset/test/X_test.txt")
test.y <- read.table("dataset/test/y_test.txt")

## Read the train data
train.sub <- read.table("dataset/train/subject_train.txt")
train.x <- read.table("dataset/train/X_train.txt")
train.y <- read.table("dataset/train/y_train.txt")

## Row bind train and test data as all.sub, all.x and all.y
all.sub <- rbind(train.sub, test.sub)
all.x <- rbind(train.x, test.x)
all.y <- rbind(train.y, test.y)

## Column bind all.x and all.y to form the combined dataset as 'all'
all <- cbind(all.sub, all.x, all.y)

## Put headers from features list
colnames(all) <- c("subject", as.character(feat$V2), "activity.id")

## Merging activity label with all data (I should have done this earlier to optimise the code)
all <- merge(all, act, by.x="activity.id", by.y="V1", all=T)

## Loading the dplyr lib
library(dplyr)

## Select the column names contains "mean" and "std" along with subject and V2/activity.label
## First rename the V2 column to activity.label
##Duplicate column names
colnames(all) <- make.names(colnames(all), unique=TRUE)
all <- rename(all, activity.label = V2)
## Select necessary columns
all <- select(all, subject, activity.label, contains("mean"), contains("std"))
## Removing unnecessary punctuations from col names
colnames(all) <- gsub('\\.\\.', '\\.', colnames(all))
colnames(all) <- gsub('\\.\\.', '\\.', colnames(all))
colnames(all) <- gsub('\\.$', '', colnames(all))

## Writing data to txt file (unfortunaitely I didn't understand the last part)
write.table(all, "output.txt")


