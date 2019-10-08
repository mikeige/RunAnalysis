# RunAnalysis
This repository contains a submission for the Getting and Cleaning Data course project by Mike Ige. 

It highlights steps for data pre-processing of the UCI Human Activity Recognition dataset.

Files

    CodeBook.md a code book that describes the steps scripted for data pre-processing of the dataset.
	
    run_analysis.R contains the actual script, sequenced according to the project requirements.
        1. Merges the training and the test sets to create one data set.
        2. Extracts only the measurements on the mean and standard deviation for each measurement.
        3. Uses descriptive activity names to name the activities in the data set
        4. Appropriately labels the data set with descriptive variable names.
        5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    TidyData.txt contains the exported datatable after going through all the processes above.

