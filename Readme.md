Getting and Cleaning Data Project

The purpose of this R script is to read data sets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, merge the data of subject, activity, and features for each training, test, and features data sets, create tidy data based on tidy data principles and finally create a second independently set of data sets with the average of each variable for the activity and subject variables. The following artifacts are posted on GitHub:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

run_analysis.R : The R-code run on the data set with averages of each variable for activity and subject variables.

SecTidySet.txt : The clean data extracted from the original data using 

CodeBook.md : The CodeBook reference to the variables in seconddata.txt

README.md : The analysis of the code in run_analysis.R

There are 3 number of data set libraries used in this code: 
1. Metadata that comprises data from data set files features.txt and activity_labels.txt; 
2. Training data that comprises: data from data set files: subject_train.txt, y_train.txt, and x_train.txt; 
3. Test data that comprises data from data set files: subject_test.txt, y_test.txt, and x_test.txt.

We should create one R script called run_analysis.R that does the following.
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Additional Information:
You can find additional information about the variables, data and transformations in the codeBook.md file
