library(dplyr)
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="C:/Users/User/Desktop/week4/data")

# Read the training data sets and labels
setwd("C:/Users/user/Desktop/week4/data/UCI HAR Dataset")
data_train<-read.table("./train/X_train.txt")
label_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")

# Read test data
data_test<-read.table("./test/X_test.txt")
label_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")

#Read activity labels
activity_labels<-read.table("./activity_labels.txt")

# Merge the training and test set
label<-rbind(label_train,label_test)
data<-rbind(data_train,data_test)
subject<-rbind(subject_train,subject_test)


feature_names<- read.table("./features.txt", head = FALSE)
names(subject)<-c("Subject")
names(label)<- c("Activity")
names(data) <- feature_names$V2

complete_data<-cbind(label, subject, data)
tolower(names(complete_data))
# Extract measurement of mean and standard deviation
mean_and_std <- complete_data %>% select(Subject, Activity, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set

mean_and_std$"Activity"[mean_and_std$"Activity" == 1] <- "Walking"
mean_and_std$"Activity"[mean_and_std$"Activity" == 2] <- "Walking Up Stairs"
mean_and_std$"Activity"[mean_and_std$"Activity" == 3] <- "Walking Down Stairs"
mean_and_std$"Activity"[mean_and_std$"Activity" == 4] <- "Sitting"
mean_and_std$"Activity"[mean_and_std$"Activity" == 5] <- "Standing"
mean_and_std$"Activity"[mean_and_std$"Activity" == 6] <- "Laying"


#Appropriately labels the data set with descriptive variable names

names(mean_and_std)<-gsub("Acc", "Accelerometer", names(mean_and_std))
names(mean_and_std)<-gsub("Gyro", "Gyroscope", names(mean_and_std))
names(mean_and_std)<-gsub("BodyBody", "Body", names(mean_and_std))
names(mean_and_std)<-gsub("Mag", "Magnitude", names(mean_and_std))
names(mean_and_std)<-gsub("^t", "Time", names(mean_and_std))
names(mean_and_std)<-gsub("^f", "Frequency", names(mean_and_std))
names(mean_and_std)<-gsub("-mean()", "Mean", names(mean_and_std), ignore.case = TRUE)
names(mean_and_std)<-gsub("-std()", "STD", names(mean_and_std), ignore.case = TRUE)
names(mean_and_std)<-gsub("-freq()", "Frequency", names(mean_and_std), ignore.case = TRUE)
#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
Final_data <- mean_and_std %>%
  group_by(Subject, Activity) %>% summarise_all(funs(mean))
write.table(Final_data, "Final_data.txt", row.name=FALSE)


