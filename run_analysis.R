## Read the text files for into tables
testreading <- read.table("./test/X_test.txt")
subjects <- read.table("./test/subject_test.txt")
activitydata <- read.table("./test/y_test.txt")
activitylabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
## Merge the activity data with the labels
activities <- merge(activitydata, activitylabels, by = "V1")
## rename columns
names(activities)[2] = "Activity"
names(subjects)[1] = "Subject"
## Combine the subject data with activity labels
testdata <- cbind(subjects, "Activity" = activities$Activity)
## Name the reading data columns and combine with subject/activity
names(testreading) <- features[,2]
testdata <- cbind(testdata, testreading)
## Repeat for training data
trainreading <- read.table("./train/X_train.txt")
trainsubjects <- read.table("./train/subject_train.txt")
trainactivitydata <- read.table("./train/y_train.txt")
trainactivities <- merge(trainactivitydata, activitylabels, by = "V1")
names(trainactivities)[2] = "Activity"
names(trainsubjects)[1] = "Subject"
traindata <- cbind(trainsubjects, "Activity" = trainactivities$Activity)
names(trainreading) <- features[,2]
traindata <- cbind(traindata, trainreading)
## Combine the train and test rows into one data set
combined <- rbind(traindata, testdata)
## Find columns with "-mean(" or "-std("
mean_std <- c(grep("-mean[(]", names(combined)), grep("-std[(]", names(combined)))
## Select only subject, activity, and mean/std
combinedselect <- combined[,c(1,2,mean_std)]
## Group by Subject and Activity, and summarize numeric columns by average
grouped <- combinedselect %>% group_by(Subject, Activity) %>% summarize_if(is.numeric, mean)
## Export data set
write.table(grouped, "Course Project dataset Vinsel.txt", row.name = FALSE)