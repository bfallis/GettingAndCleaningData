################################################################################
#
# Coursera Getting and Cleaning Data Course Project
#
# Tasks:
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
# 
# v0.001 - B.Fallis - 2019/06/22 - Script creation
#
################################################################################

#load required packages
library(data.table)
library(dplyr)

#set download location
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Set destionation file name
destFile <- "GettingAndCleaningDataFinalCoursework.zip"

# Check if zip file exists and if not download it
if (!file.exists(destFile)){
        download.file(fileURL, destFile)
}  

# Check if already unzipped and if not unarchive
if (!file.exists("UCI HAR Dataset")) { 
        unzip(destFile) 
}

#create dataframes
activities    <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features      <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subject_test  <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test        <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train       <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_test        <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
y_train       <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1. Merges the training and the test sets to create one data set.
test    <- rbind(x_train, x_test)
train   <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
mData   <- cbind(subject, train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
finalData <- mData %>% select(subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set.
finalData$code <- activities[finalData$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.
names(finalData)[1] = "Subject"
names(finalData)[2] = "Activity"
names(finalData) <- gsub("Acc", "Accelerometer", names(finalData))
names(finalData) <- gsub("Gyro", "Gyroscope", names(finalData))
names(finalData) <- gsub("BodyBody", "Body", names(finalData))
names(finalData) <- gsub("Mag", "Magnitude", names(finalData))
names(finalData) <- gsub("^t", "Time", names(finalData))
names(finalData) <- gsub("^f", "Frequency", names(finalData))
names(finalData) <- gsub("tBody", "TimeBody", names(finalData))
names(finalData) <- gsub("-mean()", "Mean", names(finalData), ignore.case = TRUE)
names(finalData) <- gsub("-std()", "STD", names(finalData), ignore.case = TRUE)
names(finalData) <- gsub("-freq()", "Frequency", names(finalData), ignore.case = TRUE)
names(finalData) <- gsub("angle", "Angle", names(finalData))
names(finalData) <- gsub("gravity", "Gravity", names(finalData))


# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
independent <- finalData %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))

#Write out data to text file
write.table(independent, "independent.txt", row.name=FALSE)
