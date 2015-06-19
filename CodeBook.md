# Human Activity Recognition Using Smartphones Data Set

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Wrangling and analysis

The data wrangling work done over the files received had the intent of cleaning the folder from the whole list of tracked features, leaving just the necessary ones. In the end, the expected result was to have a list of means in subject/activity/variable, what you will find saved in the `tidydata.txt` file if you run `source("run_analysis.R")` in your R.

The available variables are the following:

* **subject**: Assumes a value from 1 to 30, representing the subject tested.
* **activity**: Describes the action made by the subject, being `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.
* **measurement**: What measurement the column `value` will contain.
* **value**: A number correspondent to `measurement` label.

All values has the unit of frequency of happening, measures re-made at a constant rate of 50 Hz. For more information, check `UCI HAR Dataset/features_info.txt`.

```
[1] "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"
[3] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"
[5] "fBodyAcc-std-Y"            "fBodyAcc-std-Z"
[7] "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"
[9] "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"
[11] "fBodyAccJerk-std-Y"        "fBodyAccJerk-std-Z"
[13] "fBodyAccMag-mean"          "fBodyAccMag-std"
[15] "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"  
[17] "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std"
[19] "fBodyBodyGyroMag-mean"     "fBodyBodyGyroMag-std"
[21] "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"
[23] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"
[25] "fBodyGyro-std-Y"           "fBodyGyro-std-Z"
[27] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"
[29] "tBodyAcc-mean-Z"           "tBodyAcc-std-X"
[31] "tBodyAcc-std-Y"            "tBodyAcc-std-Z"
[33] "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"
[35] "tBodyAccJerk-mean-Z"       "tBodyAccJerk-std-X"
[37] "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"
[39] "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"
[41] "tBodyAccMag-mean"          "tBodyAccMag-std"
[43] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"
[45] "tBodyGyro-mean-Z"          "tBodyGyro-std-X"
[47] "tBodyGyro-std-Y"           "tBodyGyro-std-Z"
[49] "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"
[51] "tBodyGyroJerk-mean-Z"      "tBodyGyroJerk-std-X"
[53] "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"
[55] "tBodyGyroJerkMag-mean"     "tBodyGyroJerkMag-std"
[57] "tBodyGyroMag-mean"         "tBodyGyroMag-std"
[59] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"
[61] "tGravityAcc-mean-Z"        "tGravityAcc-std-X"
[63] "tGravityAcc-std-Y"         "tGravityAcc-std-Z"
[65] "tGravityAccMag-mean"       "tGravityAccMag-std"
```

About the meaning of each value, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

## Source

Data was acquired at [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). There is also an [alternative URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) for its direct download.
