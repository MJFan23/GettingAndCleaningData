
##Part 1

####Set working directory
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

####Merging Train and Test data in one dataset 
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)

##Part 2

###Extracting only the measurements on the mean and standard deviation for each measurement.

index<-grep("mean\\(\\)|std\\(\\)", features[,2]) ##getting features indeces which contain mean() and std() in their name
length(index) ## count of features
X<-X[,index] ## getting only variables with mean/stdev

##Part 3

###Uses descriptive activity names to name the activities in the data set
Y[,1]<-activity[Y[,1],2] ## replacing numeric values with lookup value from activity.txt; won't reorder Y set
head(Y)

##Part 4
###Appropriately labels the data set with descriptive variable names.

names<-features[index,2] ## getting names for variables
names(X)<-names ## updating colNames for new dataset
names(Subject)<-"SubjectID"
names(Y)<-"Activity"

CleanData<-cbind(Subject, Y, X)
head(CleanedData[,c(1:4)]) 

##Part 5
###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

CleanData<-data.table(CleanData)
TidyData <- CleanData[, lapply(.SD, mean), by = 'SubjectID,Activity'] ## features average by Subject and by activity
dim(TidyData)
Write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
head(TidyData[order(SubjectID)][,c(1:4), with = FALSE],12) 

if(!file.exists(outputDir)) { dir.create(outputDir) }
write.txt(TidyData, outputFile) ##Writing to .txt