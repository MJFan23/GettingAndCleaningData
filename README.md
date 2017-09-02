# GettingAndCleaningData

## Introduction
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
  
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Part 1

#### Set working directory
setwd ("/Users/Lauren/Documents/Data Science Coursera/Course2")

#### Reading Test data:
XTest<- read.table("/test/X_test.txt")
YTest<- read.table("/test/Y_test.txt")
SubjectTest <-read.table("/test/subject_test.txt")

#### Reading Train data:
XTrain<- read.table("/train/X_train.txt")
YTrain<- read.table("/train/Y_train.txt")
SubjectTrain <-read.table("/train/subject_train.txt")

#### Reading Features data
features<-read.table("/features.txt")

#### Reading Activity data
activity<-read.table("/activity_labels.txt")

#### Merging Train and Test data in one dataset 
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)

## Part 2

### Extracting only the measurements on the mean and standard deviation for each measurement.

index<-grep("mean\\(\\)|std\\(\\)", features[,2]) 
length(index) 
X<-X[,index]

## Part 3

### Uses descriptive activity names to name the activities in the data set
Y[,1]<-activity[Y[,1],2] 
head(Y)

## Part 4
### Appropriately labels the data set with descriptive variable names.

names<-features[index,2]
names(X)<-names 
names(Subject)<-"SubjectID"
names(Y)<-"Activity"

CleanData<-cbind(Subject, Y, X)
head(CleanedData[,c(1:4)]) 

## Part 5
### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanData<-data.table(CleanData)
TidyData <- CleanData[, lapply(.SD, mean), by = 'SubjectID,Activity'] 
dim(TidyData)
Write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
head(TidyData[order(SubjectID)][,c(1:4), with = FALSE],12) 
