# Exercise
#
# The purpose of this project is to demonstrate your ability to collect,
# work with, and clean a data set. The goal is to prepare tidy data
# that can be used for later analysis. You will be required to submit:
# 1) a tidy data set as described below,
# 2) a link to a Github repository with your script for performing the analysis, and
# 3) a code book that describes the variables, the data, and any transformations
# or work that you performed to clean up the data called CodeBook.md.
# You should also include a README.md in the repo with your scripts.
# This repo explains how all of the scripts work and how they are connected.

# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject.

install.packages(c("dplyr", "reshape"))
library(dplyr)
library(reshape)

# Download data

file_name <- "UCI HAR Dataset"
if(!file.exists(file_name)) {
  zip_name <- "UCI HAR Dataset.zip"
  if(!file.exists(zip_name))
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zip_name, method="curl")
  unzip(zip_name)
}

setwd("UCI HAR Dataset")

# Read list of data variables
#   Specially useful for giving names for columns

activity.labels <- read.table("activity_labels.txt", col.names=c("id", "label")) %>%
  select(label)
features <- read.table("features.txt", col.names=c("id", "label")) %>%
  select(label)
y.test <- read.table("test/y_test.txt", col.names=c("activity"))
y.train <- read.table("train/y_train.txt", col.names=c("activity"))

# Read observations

subject.test <- read.table("test/subject_test.txt", col.names=c("subject"))
x.test <- read.table("test/X_test.txt")
subject.train <- read.table("train/subject_train.txt", col.names=c("subject"))
x.train <- read.table("train/X_train.txt")

# Merge multiple columns into the same data.frame

y.test <- activity.labels[y.test$activity, ]
names(x.test) <- features[, 1]
y.train <- activity.labels[y.train$activity, ]
names(x.train) <- features[, 1]
test.data <- cbind(subject.test, activity=y.test, x.test)
train.data <- cbind(subject.train, activity=y.train, x.train)

# Merge test and train datasets into the same data.frame

data <- rbind(test.data, train.data)

# Filter measurements of mean and standard deviation

new.columns <- grep("mean\\(|std\\(", names(data))
observations <- data[, append(c(1, 2), new.columns)]

# Aggregate groups of subject/activity/variable by mean

tidy <- melt(observations, id=c("subject","activity"))
tidy$variable <- unlist(lapply(tidy$variable, function (x) sub("\\(\\)", "", x)))
tidy <- aggregate(value ~ subject + activity + variable, data=tidy, mean)

# Write the tidy data set out

write.table(tidy, file="../tidydata.txt", row.name=FALSE)
