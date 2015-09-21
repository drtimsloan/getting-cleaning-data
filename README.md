# getting-cleaning-data
Files for the Getting and Cleaning Data course project

## run_analysis.R
This script performs the following functions:

1) Downloads the Human Activity Recognition Using Smartphones dataset from the UCI Machine Learning repository.
The downloaded file is unzipped to a subfolder, which is then set as the new working directory.
This step can be skipped if the data is already available in the current working directory.

2) Loads the files from the train and test datasets, keeping the variable, activity and subject data in separate tables.
The activity and feature labels are also loaded in and stored as separate vectors.

3) Merges the test and train data with rbind and then uses a substring search to find all the mean and standard deviation variables.
As the 'meanFreq' columns are not strictly mean values for each measurement, these are searched separately and removed from the list.
The final list of variables is then used to subset the dataset.

4) The activity codes are converted to activity labels using the activity label vector. 
Subject, activity and variables are combined together with cbind into a single data frame. 
The data frame is reshaped with melt to place all the variables in a single column and
then recast with only the mean values for each variable by subject and activity. 
The final tidy dataset is written with write.table.

## CodeBook.md
This contains information about the data including full descriptions of the variables and how they were calculated.
