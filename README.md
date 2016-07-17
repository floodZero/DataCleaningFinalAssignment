==================================================================
Peer Graded Assignment: Getting and Cleaning Data Course Project
==================================================================
Gavin Kim - myunghoonse@gmail.com
==================================================================

This is for assignment of Coursera's "Getting and Cleaning Data Course".
This program loads smartphone's accelerometer and gyroscope data and level and manipulate to calculate means of it.
Required library is "data.table"since it's performance and efficienty of usage.


The "run_analysis.R" program consists of four parts.

1. Load data to Data table
2. Extract columns of mean and std each feature
3. Aggregate and calculate the column's mean for each activity and each subject
4. Save the data to "./SampleOutput/output.txt" path


Below is description of directories.

1. SampleOutput - location for saving final file
2. UCI HAR Dataset - smartphone data sets what program will use as input


Functions in program.

1. loadData <- function(parentPath, type, columnNames, activityLevels)

This function will load and assign column names to the data.
And also levels to Y data with factorizing.
Y is activity indices value. it's representing states in "./UCI HAR Dataset/activity_labels.txt" file.
But these column name list and activity level list have to deliverd through argument of function.
This is for re-usability of function.