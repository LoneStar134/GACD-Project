#Set working directory
setwd("~/Dropbox/Coursera/JH Data Science/Getting and Cleaning Data/Week 3/Project/UCI HAR Dataset");
library("reshape2")

#set numeric precision to 15 digits
options(digits=15)

#Load feature column names and activity labels           
colnames = read.table("features.txt",col.names=c("featureNbr","featureName"))              
actlabels = read.table("activity_labels.txt",col.names=c("activityNbr","activityName"))

#Load data sets
testx = read.table("test/X_test.txt",col.names = colnames[,2])
testy = read.table("test/Y_test.txt",col.names = c("activityNbr"))

#merge the activity names
testy = merge(testy,actlabels,by.x="activityNbr",by.y="activityNbr")

testsub = read.table("test/subject_test.txt",col.names = c("subjectNbr"))
testbgy = read.table("test/Inertial Signals/body_gyro_y_test.txt",col.names=paste("BGY",1:128))
testbgz = read.table("test/Inertial Signals/body_gyro_z_test.txt",col.names=paste("BGZ",1:128))
testbgx = read.table("test/Inertial Signals/body_gyro_x_test.txt",col.names=paste("BGX",1:128))
testtay = read.table("test/Inertial Signals/total_acc_y_test.txt",col.names=paste("TAY",1:128))
testtaz = read.table("test/Inertial Signals/total_acc_z_test.txt",col.names=paste("TAZ",1:128))
testtax = read.table("test/Inertial Signals/total_acc_x_test.txt",col.names=paste("TAX",1:128))
testbay = read.table("test/Inertial Signals/body_acc_y_test.txt",col.names=paste("BAY",1:128))
testbaz = read.table("test/Inertial Signals/body_acc_z_test.txt",col.names=paste("BAZ",1:128))
testbax = read.table("test/Inertial Signals/body_acc_x_test.txt",col.names=paste("BAX",1:128))

#bind test data sets into one data frame and delete all individual test data sets
testset = cbind(testx,testy,testsub,testbgy,testbgz,testbgx,testtay,testtaz,testtax,testbay,testbaz,testbax)
remove(testx,testy,testsub,testbgy,testbgz,testbgx,testtay,testtaz,testtax,testbay,testbaz,testbax)

trainx = read.table("train/X_train.txt",col.names = colnames[,2])
trainy = read.table("train/Y_train.txt",col.names = c("activityNbr"))

#merge the activity names
trainy = merge(trainy,actlabels,by.x="activityNbr",by.y="activityNbr")

trainsub = read.table("train/subject_train.txt",col.names = c("subjectNbr"))
trainbgy = read.table("train/Inertial Signals/body_gyro_y_train.txt",col.names=paste("BGY",1:128))
trainbgz = read.table("train/Inertial Signals/body_gyro_z_train.txt",col.names=paste("BGZ",1:128))
trainbgx = read.table("train/Inertial Signals/body_gyro_x_train.txt",col.names=paste("BGX",1:128))
traintay = read.table("train/Inertial Signals/total_acc_y_train.txt",col.names=paste("TAY",1:128))
traintaz = read.table("train/Inertial Signals/total_acc_z_train.txt",col.names=paste("TAZ",1:128))
traintax = read.table("train/Inertial Signals/total_acc_x_train.txt",col.names=paste("TAX",1:128))
trainbay = read.table("train/Inertial Signals/body_acc_y_train.txt" ,col.names=paste("BAY",1:128))
trainbaz = read.table("train/Inertial Signals/body_acc_z_train.txt" ,col.names=paste("BAZ",1:128))
trainbax = read.table("train/Inertial Signals/body_acc_x_train.txt" ,col.names=paste("BAX",1:128))

#bind train data sets into one data frame and delete all individual train data sets
trainset = cbind(trainx,trainy,trainsub,trainbgy,trainbgz,trainbgx,traintay,traintaz,traintax,trainbay,trainbaz,trainbax)
remove(trainx,trainy,trainsub,trainbgy,trainbgz,trainbgx,traintay,traintaz,traintax,trainbay,trainbaz,trainbax)

#merge test and training data sets into one dataframe
bigset = rbind(testset,trainset)

#clean up
remove(testset,trainset,colnames,actlabels)

#melt the big data
bsmelt1 = melt(bigset,id=c("subjectNbr","activityNbr","activityName"))
#bsmelt = head(bsmelt1[grepl("mean",bsmelt1$variable),c("subjectNbr","activityName","variable","value")])
bsmelt = subset(bsmelt1,grepl("mean",bsmelt1$variable) )

#tidy up the dataset
tidyset = dcast(bsmelt,subjectNbr+activityName~variable,mean)

#clean up some
remove(bsmelt1)
#output tidyset to a file
write.table(tidyset,"tidyset-final.csv")
