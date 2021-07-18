library(dplyr)
library(plyr)
library(reshape2)
#merging train and test data

#train data
x_train<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")  
subject_train<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

#test data
x_test<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

#merging
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

#loading feature and activity info
feature <- read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activity_labels <- read.table("C://Users/Tarandeep Kaur/Documents/R/Getting-and-Cleaning-Data-Course-Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")

#extracting colnames with mean,std
selected_cols <- grep("-(mean|std).*",feature[,2])
selectedColNames <- feature[selected_cols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)

#extract data by cols & using descriptive name
x_data <- x_data[selected_cols]
allData <- cbind(subject_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
allData$Subject <- as.factor(allData$Subject)


#generate tidy data set

meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)




