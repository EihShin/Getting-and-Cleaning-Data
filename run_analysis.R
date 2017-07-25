label<-read.table("activity_labels.txt")
names(label)<-c("activity","activityName")
feature<-read.table("features.txt")

#train
trainsubject<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/train/subject_train.txt")
xtrain<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/train/X_train.txt")
ytrain<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/train/y_train.txt")

#test
testsubject<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/test/subject_test.txt")
xtest<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/test/X_test.txt")
ytest<-read.table("C:/Users/User/Desktop/Getting and Cleaning Data/test/y_test.txt")

#Extract mean adn std columns
names(xtrain)<-c(paste(feature$V2))
xtrain<-xtrain[, grep(".*mean.*|.*std.*", colnames(xtrain))]
names(xtest)<-c(paste(feature$V2))
xtest<-xtest[, grep(".*mean.*|.*std.*", colnames(xtest))]

#Combine all
trainset<-cbind(trainsubject,ytrain,xtrain)
testset<-cbind(testsubject,ytest,xtest)
allData<-rbind(trainset,testset)

#Tidy names

names(allData)<-gsub("mean", "Mean", names(allData))
names(allData)<-gsub("std", "Std", names(allData))
names(allData)<-gsub("[-]", "", names(allData))
names(allData)<-gsub("[(][)]", "", names(allData))
names(allData)<-c("subject","activity",names(allData[,3:ncol(allData)]))


library(reshape2)
#Aggregate mean
df_melt <- melt(allData, id = c("subject", "activity"))
allmean<-dcast(df_melt, subject + activity ~ variable, mean)

merge<-merge(x = allmean, y = label, by = "activity", all.x=TRUE)

#order columns and remove extra columns
newdata<-merge[order(merge$subject),c(2,ncol(merge),3:(ncol(merge)-1))]

write.table(newdata, "tidy.txt", row.names = FALSE, quote = FALSE)
tidy<-read.table("tidy.txt")
