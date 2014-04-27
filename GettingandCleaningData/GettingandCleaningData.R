

###Load dataset
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
dataset<-rbind(X_train,X_test)



###Filter features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]


meanF<-grepl("mean()", features )
stdF<-grepl("std()", features )

dataset<-data.frame(dataset[,(meanF | stdF )])

names<-features[(meanF | stdF )]
names<-gsub("[()]", "",names)
names<-gsub("[-]", ".",names)
colnames(dataset)<-names




###Subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjects<- c(subject_train[,1], subject_test[,1])




##Activities
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
activities<-rbind(y_train,y_test)
activities<-cbind(activities,(1:dim(activities)[1]))
names(activities)<-c("V1","POS")




####Merge sibjects, activities and dataset
M<-merge(x = activities, y = activity_labels, by = "V1",all.x=TRUE)
activ_names<-M[order(as.numeric(M$POS)),"V2"]


dataset<-cbind(as.numeric(subjects),activ_names ,dataset)



##Summarize data

library(plyr)

tidyData <- ddply(
dataset, .(subjects, activ_names),function(x){colMeans(x[,3:(dim(x)[2])])})



write.table(tidyData , "data.txt")




