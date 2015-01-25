# tidydata
Coursera Course Project for "Getting and Cleaning Data"

##Tasks To Do
You should create one R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one dataset.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the dataset
4. Appropriately labels the dataset with descriptive variable names.
5. From the dataset in step4, create a second, independent tidy dataset with the average of each variable for each activity and each subject.

### Basic checking for existance of data files
-dir.exist is not a supported function, so we are checking whether features.txt is available inside the dataset directory in current working directory

### Reading data
-Read the features text in the variable named "feat"
-Read the activity_labels text in the variable named "act"
-Read the test data
-Read the train data

### Binding rows and columns
1. Row bind train and test data as all.sub, all.x and all.y
`````
all.sub <- rbind(train.sub, test.sub)
all.x <- rbind(train.x, test.x)
all.y <- rbind(train.y, test.y)
`````
2. Column bind all.x and all.y to form the combined dataset as 'all'
`````
all <- cbind(all.sub, all.x, all.y)
`````
3. Put headers from features list
`````
colnames(all) <- c("subject", as.character(feat$V2), "activity.id")
`````
4. Merging activity label with all data (I should have done this earlier to optimise the code)
`````
all <- merge(all, act, by.x="activity.id", by.y="V1", all=T)
`````

### Loading the dplyr lib **optional**

### Select the appropriate columns
- column names contains `mean` and `std` along with `subject` and `V2/activity.label`
- Remove Duplicate column names
`````
colnames(all) <- make.names(colnames(all), unique=TRUE)
`````
- First rename the V2 column to activity.label
- Select necessary columns
- Removing unnecessary punctuations from col names

### Write the data using write.table


