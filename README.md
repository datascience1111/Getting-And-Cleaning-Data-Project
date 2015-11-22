Data Source

This dataset dervies from the Human Activity Recogniation Using Smartphones Data Set published by the University of California at Irvine (UCI) at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Overview of run_analysis.R

1) This script downloads the zipped data set from UCI and unzip's it to a specified directory in your computer directory.

2) Second, run_analysis.R build a method to only extract the measurments captured in the test & train data sets that contain the mean or standard deviation.

3) Third, this script merges the test and train data sets into one data frame.  Next, run_analysis.R cleans the data by narrowing the merged data set for only measurements with mean and standard deviation using the aforementioned processes.  

4) Fourth, run_analysis.R cleans up the column headers through 12 instructions pertaining to proper capitalization, expanded abbreviations, removing uneeded hyphens, and redundant words.

5) This script matches column value with their approprate descrtiptive activity.  For example, instead of listing a "1" as a measurement, run_analysis.R coorelates and inserts a descirptive string such as "walking".  Finally,  run_analysis.R creates a second independent tidy data set that calculates the average of each variable for each activity and each subject and writes it to a file "run_data_summary.txt".