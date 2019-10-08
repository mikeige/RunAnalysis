library (dplyr)
# Downloading the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCIHAR.zip", method="curl" )

# Unziping dataset to local folder
unzip("UCIHAR.zip")

# Assigning each sub dataset to variables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("No","functions"))

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merging the training and the test sets to create one data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)
Data <- cbind(Subjects, Y, X)

# Extracting only the measurements on the mean and standard deviation for each measurement
mSDData <- select(Data, subject, code, contains("mean"), contains("std"))

# Using descriptive activity names to name the activities in the data set
mSDData$code <- activity_labels[mSDData$code, 2]

names(mSDData)[2] = "activity"

# Appropriately labelling the data set with descriptive variable names
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

# Creating a second, independent tidy data set after grouping by subject and activity and averaging
AvgData <- mSDData %>% group_by(subject, activity) %>% summarize_all(funs(mean))

# Exporting dataset to a local .txt file
write.table(AvgData, "TidyData.txt", row.name=FALSE)
