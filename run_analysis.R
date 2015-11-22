library(base)
library(utils)
library(data.table)
library(dplyr)
rm(list = ls())
if(!file.exists("./data")){dir.create("./data")}

zip.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(zip.url, destfile = "./data/UCI HAR Dataset.zip", mode = "wb")
unzip("./data/UCI HAR Dataset.zip", exdir = "./data")

##Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
extract_features <- grepl("mean|std", features)

X_test <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
X_train <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
y_train <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)

subject_test <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",sep = "", header = FALSE)
subject_train<- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
activity_labels <- read.table("./data/UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)         


##Merges the training and the test sets to create one data set.
train <- data.frame(subject_train, y_train, X_train)
test <- data.frame(subject_test, y_test, X_test)

mergedData = merge(train, test, all = TRUE)
column_names <- as.vector(features[,2])

##After merging data, narrow down to std and mean observations for each subject and activity
mergedData2 <- mergedData[,grepl("std|mean|subject|activity", colnames(mergedData))]

COLNAMES_FINAL = colnames(mergedData2)

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

colnames(mergedData2) = COLNAMES_FINAL  ##places cleaned column names back into mergedData2 variable

##Use descriptive activity names to name the activities in the data set

mergedData2$Activity_labels<- as.character(activity_labels[match(mergedData2$Activity_labels, activity_labels$V1), 'V2']) 

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

mergeddata3 <- aggregate(mergedData2[,3:ncol(mergedData2)],by=list(subject = mergedData2$Subject_id, label = mergedData2$Activity_labels), mean)

write.table(mergeddata3, file = "run_data_summary.txt", row.names = FALSE)




