# Getting and Cleaning Data Course Project

## (Optional) 1) Download the file and change the working directory
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "UCI_HAR_dataset.zip")
date_download <- Sys.time()
unzip("UCI_HAR_dataset.zip")
setwd("./UCI HAR Dataset")

## 2) Load datasets and label sets
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
features_info <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
features <- as.character(features_info$V2)

## 3) Combine the data and subset the columns for mean and std
X_all <- rbind(X_train, X_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)
mean_freq <- grep("meanFreq",features)
mean_vec <- grep("mean", features)
std_vec <- grep("std", features)
mean_std_vec <- sort(c(mean_vec[!mean_vec %in% mean_freq], std_vec))
X_subset <- X_all[,mean_std_vec]
names(X_subset) <- gsub("\\()","",features[mean_std_vec])

## 4) Reshape the data and create a new dataset with variable means by subject and activity
library(reshape2)
subject <- as.factor(subject_all$V1)
activity <- activity_labels[y_all$V1,2]
full_set <- cbind(subject, activity, X_subset)
fullMelt <- melt(full_set, id = c("subject","activity"), measure.vars = names(X_subset))#features[mean_std_vec])
tidy_set <- dcast(fullMelt, subject + activity ~ variable, mean)
write.table(tidy_set, file = "tidy_set.txt", row.names = FALSE)