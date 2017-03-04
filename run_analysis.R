library(quantmod)
library(data.table)
library(plyr)
library(dplyr)
library(reshape2)
library(gtools)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#1.Merging the training and the test sets to create one data set

#Reading Train and Test tables
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")


#Reading Feature
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Reading Activitiy Labels 
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Assigning Column Names to the data loaded
colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityID"
colnames(subjectTrain) <- "subjectID"

colnames(xtest) <- features[,2]
colnames(ytest) <- "activityID"
colnames(subjectTest) <- "subjectID"


colnames(activities) <- c("activityID","activityType")

#Merging Test Data

testdata <- cbind(ytest, subjectTest, xtest)

#Merging Train Data

traindata <- cbind(ytrain, subjectTrain, xtrain)

#Merging Test and Training Data Sets

finalData <- rbind(traindata , testdata)

#2.Extracts only the measurements on the mean and standard deviation for each measurement

colNames <- colnames(finalData)

mean_and_std <- (grepl("activityID" , colNames) | 
                   grepl("subjectID" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

#subsetting final data column as per requirement
setForMean_Std <- finalData[ , mean_and_std == TRUE]

#3.Uses descriptive activity names to name the activities in the data set
setwithActvtyLabels <- merge(setForMean_Std , activities, all.x = TRUE, by.x = 'activityID')

# Updating the colNames vector to include the new column names after merge
colNames <- colnames(setwithActvtyLabels)

#4.Appropriately labels the data set with descriptive variable names

#Cleaning Variables names

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Making second tidy data set
secTidySet <- aggregate(. ~subjectID + activityID, setwithActvtyLabels, mean)
secTidySet <- secTidySet[order(secTidySet$subjectID, secTidySet$activityID),]

#Writing second tidy data set in txt file
write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
