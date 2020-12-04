# 1

subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')
test_x<-read.table('./UCI HAR Dataset/test/X_test.txt')
test_y<-read.table('./UCI HAR Dataset/test/y_test.txt')

subject_train<-read.table('./UCI HAR Dataset/train/subject_train.txt')
train_x<-read.table('./UCI HAR Dataset/train/X_train.txt')
train_y<-read.table('./UCI HAR Dataset/train/y_train.txt')

test<-cbind(subject_test, test_y, test_x)
train<-cbind(subject_train, train_y, train_x)

data<-rbind(train, test)

cnames<-read.table('./UCI HAR Dataset/features.txt')
cnames_t<-t(cnames)
cnames_t_f<-cnames_t[2, ]

colnames (data)<-c("SubjectID", "Activity", cnames_t_f)

# 2
mean_std<-data[ , grep("-mean\\(\\)|-std\\(\\)", colnames(data))]
mean_std<-cbind(data, data$Activity, mean_std)
colnames(mean_std)[1:2]<-c("SubjectID", "Activity")

# 3
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
mean_std$ActivityName <- factor(mean_std$Activity, labels = activity_labels[,2])

# 4
mean_std<-subset(mean_std,select = c(SubjectID, Activity, ActivityName, 3:68))
colnames(mean_std) <- gsub("^t", "Time", colnames(mean_std))
colnames(mean_std) <- gsub("^f", "Frequency", colnames(mean_std))
colnames(mean_std) <- gsub("Acc", "Accelerometer", colnames(mean_std))
colnames(mean_std) <- gsub("Gyro", "Gyroscope", colnames(mean_std))
colnames(mean_std) <- gsub("Mag", "Magnitude", colnames(mean_std))

# 5
means<-aggregate(.~SubjectID+ActivityName, mean_std, mean)
means$Activity<-NULL
