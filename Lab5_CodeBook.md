# 1. Об’єднує навчальний та тестовий набори, щоб створити один набір даних.

```R
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
```

# 2. Витягує лише вимірювання середнього значення та стандартного відхилення (mean and standard deviation) для кожного вимірювання.

```R
mean_std<-data[ , grep("-mean\\(\\)|-std\\(\\)", colnames(data))]
mean_std<-cbind(data$SubjectID, data$Activity, mean_std)
colnames(mean_std)[1:2]<-c("SubjectID", "Activity")
```

# 3. Використовує описові назви діяльностей (activity) для найменування діяльностей у наборі даних.

```R
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
mean_std$ActivityName <- factor(mean_std$Activity, labels = activity_labels[,2])
```

# 4. Відповідно присвоює змінним у наборі даних описові імена.

```R
mean_std<-subset(mean_std,select = c(SubjectID, Activity, ActivityName, 3:68))
colnames(mean_std) <- gsub("^t", "Time", colnames(mean_std))
colnames(mean_std) <- gsub("^f", "Frequency", colnames(mean_std))
colnames(mean_std) <- gsub("Acc", "Accelerometer", colnames(mean_std))
colnames(mean_std) <- gsub("Gyro", "Gyroscope", colnames(mean_std))
colnames(mean_std) <- gsub("Mag", "Magnitude", colnames(mean_std))
```

# 5. З набору даних з кроку 4 створити другий незалежний акуратний набір даних (tidy dataset) із середнім значенням для кожної змінної для кожної діяльності та кожного суб’єкту (subject).

```R
means<-aggregate(.~SubjectID+ActivityName, mean_std, mean)
```
