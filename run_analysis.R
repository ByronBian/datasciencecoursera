setwd("E:\\DataScience")

#Step I: Arrange Training Data
#read training data
traindata<-read.table("./UCI_HAR/train/X_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read subject data
subject<-read.table("./UCI_HAR/train/subject_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read activity data
activity<-read.table("./UCI_HAR/train/y_train.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read features data
features<-read.table("./UCI_HAR/features.txt",header=FALSE,sep="",stringsAsFactors=FALSE)

#Update names of training data by features
names(traindata)<-features$V2
#Bind Subject and Activity Vectors
traindata<-cbind(traindata,subject,activity)
names(traindata)[562]<-"subject"
names(traindata)[563]<-"activity"

#Step II: Arrange Test Data
#read test data
testdata<-read.table("./UCI_HAR/test/X_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read subject data
subject<-read.table("./UCI_HAR/test/subject_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read activity data
activity<-read.table("./UCI_HAR/test/y_test.txt",header=FALSE,sep="",stringsAsFactors=FALSE)
#read features data
features<-read.table("./UCI_HAR/features.txt",header=FALSE,sep="",stringsAsFactors=FALSE)

#Update names of test data by features
names(testdata)<-features$V2
#Bind Subject and Activity Vectors
testdata<-cbind(testdata,subject,activity)
names(testdata)[562]<-"subject"
names(testdata)[563]<-"activity"

#Step III: Merge training data and test data into one dataset
grossdata<-rbind(traindata,testdata)

#Step IV: Extracts only the measurements on the mean and standard deviation for each measurement.
grossdata<-grossdata[,c(c(562,563),grep("[Mm]ean|[Ss]td",colnames(grossdata)))]

#Step V: Read Activity Labels
act_label<-read.table("./UCI_HAR/activity_labels.txt",header=FALSE,sep="",stringsAsFactor=FALSE)
names(act_label)<-c("activity","activitylabel")

#Step VI: Uses descriptive activity names to name the activities in the data set
grossdata<-merge(grossdata,act_label,by.x="activity",by.y="activity",all=TRUE)

#Step VII: Create a Tidy dataset called TidyData excluding ActivityLabel
library(reshape2)
tidydata<-grossdata[,1:88]

#Aggregate measurement variables by melting and casting data
tidydata<-melt(tidydata,id=c("activity","subject"),measure.vars=names(tidydata)[3:88])
tidydata<-dcast(tidydata,activity+subject~variable,mean)
#Only keep 8-digits for each of measurable variables
tidydata<-apply(tidydata,2,function(x) round(x,8))

#Step VIII: Output tidy data into a text file
write.table(tidydata,file="./tidydata.txt",sep=" ",col.names=FALSE, row.names=FALSE)
