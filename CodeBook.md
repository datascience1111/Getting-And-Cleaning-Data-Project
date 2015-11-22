Analytical Process

run_analysis.R reads in the following datasets provided by UCI's study and a brief desciption of their content:

features.txt - Shows information about the variables used on the feature vector.

X_test.txt -  Test data set

y_test.txt - Test labels

X_train.txt - Training data Set

y_train.txt - Training labels

subject_test.txt - Identifies the subject who performed the activity for each window sample ranging from 1 to 30 for the test data set.

subject_train.txt - Identifies the subject who performed the activity for each window sample ranging from 1 to 30 for the train data set.

activity_labels.txt - Links the class labels with their activity name.

run_data_summary.txt - A second tidy data set containing the average of each variable for each activity and each subject.

Variables created during analysis:

extracted_features - uses grepl function to parse features.txt to only those associated with standard deviation and mean measurements.

train - merges all trainining data into one table where each row identifies the subject who performed the activity for each window sample.  Its range is from 1 to 30.
test - merges all test data related data into one table
mergedData - merges all train & test data into one data frame
mergedData2 - reduces all merged train & test data to only those associated with standard devation and mean measurements.  This variable was also used to match activity labels with their designator
mergeddata3 - a second data set that calculates the mean of each variable for each activity and each subject
COLNAMES_FINAL = column names used for the final tidy data set.  I created this variable exclusively for cleaning the column name format in this manner:

for (i in 1:length(COLNAMES_FINAL))
{
    COLNAMES_FINAL[i] = gsub("\\()", "", COLNAMES_FINAL[i]) 
    COLNAMES_FINAL[i] = gsub("-std","StdDev",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("-mean","Mean",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("^(t)","Time-",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("^(f)","Frequency-",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("[Bb]ody","Body",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("[Ss]ubject","Subject",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("[Aa]ctivity","Activity",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("JerkMag","JerkMagnitude",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("GyroMag","GryoMagnitude",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("-BodyBody","Body",COLNAMES_FINAL[i])
    COLNAMES_FINAL[i] = gsub("Magnitudenitudenitudenitudenitude|Magnitudenitude","Magnitude",COLNAMES_FINAL[i])
    }

Description of the abbreviaitons of measurements

Notes:
======

- For any descriptor with any designation of "X" "Y" or "Z", this  describes which axis the UCI collected the signal

Leading "time" or "frequency" is based how the data was measured
Body = related to body signal obtained by subtracting the gravity from the total acceleration.
Gravity = acceleration of gravity
Acc = accleration of gravity signal from the smartphone accelerometer which is measured in standard gravity units 'g'. 
Gryo = angular velocity vector measured by the gyroscope for each window sample.  The units are radians/second.
Jerk = sudden movement acceleration
Mag = magnitude of movement
Mean = mean value for each measurement
StdDev = Standard Deviation for each measurement

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


How to download the data:

rm(list = ls())
if(!file.exists("./data")){dir.create("./data")}
zip.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(zip.url, destfile = "./data/UCI HAR Dataset.zip", mode = "wb")
unzip("./data/UCI HAR Dataset.zip", exdir = "./data")

Packages used for cleaning this data set:

library(base)
library(utils)
library(data.table)
library(dplyr)






