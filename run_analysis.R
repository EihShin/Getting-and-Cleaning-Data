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

#Tidy names
featureName<-grep(".*mean.*|.*std.*", feature$V2,value=TRUE)
featureName<-gsub("mean", "Mean", featureName)
featureName<-gsub("std", "Std", featureName)
featureName<-gsub("[-]", "", featureName)
featureName<-gsub("[(][)]", "", featureName)

trainset<-cbind(trainsubject,ytrain,xtrain)
names(trainset)<-c("subject","activity",featureName)

testset<-cbind(testsubject,ytest,xtest)
names(testset)<-c("subject","activity",featureName)

allData<-rbind(trainset,testset)

#Aggregate mean
df_melt <- melt(allData, id = c("subject", "activity"))
allmean<-dcast(df_melt, subject + activity ~ variable, mean)

merge<-merge(x = allmean, y = label, by = "activity", all.x=TRUE)
merge<-merge[order(merge$subject),]
#order columns and remove extra columns
newdata<-merge[order(merge$subject),c(2,ncol(merge),3:(ncol(merge)-2))]

write.table(newdata, "tidy.txt", row.names = FALSE, quote = FALSE)
