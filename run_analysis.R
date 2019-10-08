library (dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCIHAR.zip", method="curl" )
unzip("UCIHAR.zip")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("No","functions"))

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)
Data <- cbind(Subjects, Y, X)
mSDData <- select(Data, subject, code, contains("mean"), contains("std"))

mSDData$code <- activity_labels[mSDData$code, 2]

names(mSDData)[2] = "activity"
names(mSDData)<-gsub("Acc", "Accelerometer", names(mSDData))
names(mSDData)<-gsub("Mag", "Magnitude", names(mSDData))
names(mSDData)<-gsub("Gyro", "Gyroscope", names(mSDData))
names(mSDData)<-gsub("BodyBody", "Body", names(mSDData))
names(mSDData)<-gsub("^t", "Time", names(mSDData))
names(mSDData)<-gsub("^f", "Frequency", names(mSDData))
names(mSDData)<-gsub("tBody", "TimeBody", names(mSDData))
names(mSDData)<-gsub("-mean()", "Mean", names(mSDData), ignore.case = TRUE)
names(mSDData)<-gsub("-std()", "StdDev", names(mSDData), ignore.case = TRUE)
names(mSDData)<-gsub("-freq()", "Frequency", names(mSDData), ignore.case = TRUE)

AvgData <- mSDData %>% group_by(subject, activity) %>% summarize_all(funs(mean))

write.table(AvgData, "AvgData.txt", row.name=FALSE)
