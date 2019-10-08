

The run_analysis.R script carries out various steps in data pre-processing of the UCI Human Activity Recognition dataset 
downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

    Downloading the dataset
        Dataset is downloaded and extracted to a folder called UCI HAR Dataset

    Assigning each sub dataset to variables
		The data in the various files are brought into data tables named for each downloaded file. 
		
        features <- features.txt : 561 rows, 2 columns
		Features from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
        
		activity_labels <- activity_labels.txt : 6 rows, 2 columns
        List of activities performed when the corresponding measurements were taken and its codes (labels)
        
		subject_test <- test/subject_test.txt : 2947 rows, 1 column
        Test data of 9/30 volunteer test subjects being observed
        
		x_test <- test/X_test.txt : 2947 rows, 561 columns
        Recorded features test data
        
		y_test <- test/y_test.txt : 2947 rows, 1 columns
        Activities’code labels
        
		subject_train <- test/subject_train.txt : 7352 rows, 1 column
        Train data of 21/30 volunteer subjects being observed
        
		x_train <- test/X_train.txt : 7352 rows, 561 columns
        Recorded features train data
        
		y_train <- test/y_train.txt : 7352 rows, 1 columns
        Train data of activities’code labels

    Merging the training and the test sets to create one data set
	
        X (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
        Y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
        Subjects (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
        Data (10299 rows, 563 column) is created by merging Subjects, Y and X using cbind() function

    Extracting only the measurements on the mean and standard deviation for each measurement
        mSDData (10299 rows, 88 columns) is created by subsetting Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

    Using descriptive activity names to name the activities in the data set
        Entire numbers in code column of the mSDData replaced with corresponding activity taken from second column of the activities variable

    Appropriately labelling the data set with descriptive variable names
		The code column in mSDData is renamed to activity
        All instances of Acc in column names were replaced by Accelerometer
        All instances of Gyro in column names were replaced by Gyroscope
        All instances of BodyBody in column names were replaced by Body
        All instances of Mag in column names were replaced by Magnitude
        All instances of words starting with character f in column names were replaced by Frequency
        All instances of words startin with character t in column names were replaced by Time

	Creating a second, independent tidy data set from the above data set, with the average of each variable for each activity and each subject
        AvgData (180 rows, 88 columns) is created by grouping mSDData variables by subject and activity and summarizing their means.
    
	AvgData is then exported via write.table into a file called TidyData.txt

