#Reading the subjects list
sub_train<-data.table(read.delim('train/subject_train.txt',sep = "",header = FALSE))
#Reading the features of the training data
x_train<-data.table(read.delim('train/X_train.txt',sep = "",header = FALSE))
#Reading the activity class for each record of training data
y_train <- data.table(read.delim('train/y_train.txt',sep = "",header = FALSE))
#reading the feature names and setting them as column names for the training data
features <- data.table(read.delim('features.txt',sep = "",header = FALSE),stringsAsFactors = FALSE)
colnames(x_train) <- as.character(features$V2)
colnames(sub_train) <- c("subject")
colnames(y_train) <- c("activity")
train <- cbind(sub_train,x_train,y_train)

#Reading the subjects list
sub_test<-data.table(read.delim('test/subject_test.txt',sep = "",header = FALSE))
#Reading the features of the testing data
x_test<-data.table(read.delim('test/X_test.txt',sep = "",header = FALSE))
#Reading the activity class for each record of testing data
y_test <- data.table(read.delim('test/y_test.txt',sep = "",header = FALSE))
#setting column names for the testing data
colnames(x_test) <- as.character(features$V2)
colnames(sub_test) <- c("subject")
colnames(y_test) <- c("activity")
test <- cbind(sub_test,x_test,y_test)

#Merging the training and test datasets using rbind
train_test <- rbind(train,test)
train_test_1 <- train_test[,grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]|subject|activity",colnames(train_test)),with=FALSE]
#train_test_1 <- train_test[,grep("mean|std",colnames(train_test)),colnames(train_test)),with=FALSE]

act_labels<-data.table(read.delim('activity_labels.txt',sep = "",header = FALSE))
#Renaming activity to describe activity names
train_test_1$activityname <- act_labels[train_test_1$activity,2]

#Appropriately labels the data set with descriptive variable names
names(train_test_1) <- gsub("^t","time",names(train_test_1))
names(train_test_1) <- gsub("^f","frequency",names(train_test_1))
names(train_test_1) <- gsub("Acc","Accelerometer",names(train_test_1))
names(train_test_1) <- gsub("Gyro","Gyroscope",names(train_test_1))
names(train_test_1) <- gsub("Mag","Magnitude",names(train_test_1))
names(train_test_1) <- gsub("BodyBody","Body",names(train_test_1))
names(train_test_1) <- gsub("\\()|\\-","",names(train_test_1))
names(train_test_1) <- gsub("mean","Mean",names(train_test_1))
names(train_test_1) <- gsub("std","Std",names(train_test_1))

#Creates an independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
train_test_2 <- train_test_1 %>% group_by(activityname,subject) %>% 
  summarise_all(mean)
#Sorting by Subject & Activity
train_test_2 <- arrange(train_test_2,subject,activity)
train_test_2 <- train_test_2[,1:88]
#Writing the final dataframe to a text file
write.table(train_test_2,file = "tidydata.txt",row.name=FALSE )