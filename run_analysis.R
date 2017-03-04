
## This script does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "HumanTracking.zip")
unzip("HumanTracking.zip")
setwd("UCI HAR Dataset")

library(reshape2)

#Assing variable name to feaures an labels
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

setwd(paste(getwd(), "train", sep = "/"))

#Assign train variable names to each file according to their description from the README.txt
subject_train <- read.table("subject_train.txt")
train_set <- read.table("X_train.txt")
train_label <- read.table("y_train.txt")

#This is only for future use    
#setwd(paste(getwd(), "Inertial Signals/", sep = "/"))
#    body_acc_x_train <-  read.table("body_acc_x_train.txt")
#    body_acc_y_train <-  read.table("body_acc_y_train.txt")
#    body_acc_z_train <-  read.table("body_acc_z_train.txt") 
#    body_gyro_x_train <-  read.table("body_gyro_x_train.txt")
#    body_gyro_y_train <-  read.table("body_gyro_y_train.txt")
#    body_gyro_z_train <-  read.table("body_gyro_z_train.txt")
#    total_acc_x_train <-  read.table("total_acc_x_train.txt")
#    total_acc_y_train <-  read.table("total_acc_y_train.txt")
#    total_acc_z_train <-  read.table("total_acc_z_train.txt")

setwd("..")


setwd(paste(getwd(), "test", sep = "/"))

#Assign test variable names to each file according to their description from the README.txt
subject_test <- read.table("subject_test.txt")
test_set <- read.table("X_test.txt")
test_label <- read.table("y_test.txt")

#This is only for future use      
#setwd(paste(getwd(), "Inertial Signals/", sep = "/"))
#    body_acc_x_test <-  read.table("body_acc_x_test.txt")
#    body_acc_y_test <-  read.table("body_acc_y_test.txt")
#    body_acc_z_test <-  read.table("body_acc_z_test.txt") 
#    body_gyro_x_test <-  read.table("body_gyro_x_test.txt")
#    body_gyro_y_test <-  read.table("body_gyro_y_test.txt")
#    body_gyro_z_test <-  read.table("body_gyro_z_test.txt")
#    total_acc_x_test <-  read.table("total_acc_x_test.txt")
#    total_acc_y_test <-  read.table("total_acc_y_test.txt")
#    total_acc_z_test <-  read.table("total_acc_z_test.txt")
setwd("..")




#Label sets according to features 
names(test_set) <- features$V2
names(train_set) <- features$V2
names(test_set) <- features$V2
names(train_set) <- features$V2


#Assign activity labels to both test and train sets
activity_labels <- activity_labels$V2
test_label$V2 = activity_labels[test_label$V1]
train_label$V2 = activity_labels[train_label$V1]
names(test_label) <- c("ID_of_Act", "Activity_Label")
names(train_label) <- c("ID_of_Act", "Activity_Label")
names(subject_test) <- "subjectID"
names(subject_train) <- "subjectID"

#Add the labeled columns to the test set
all_test <- cbind(test_label, test_set)
all_test <- cbind(subject_test, all_test)

#Add the labeled columns to the train set
all_train <- cbind(train_label, train_set)
all_train <- cbind(subject_train, all_train)

#Merge test and train sets by rows
all_data <- rbind(all_test, all_train)
all_data <- all_data[, grep("mean|std", features$V2)]


#Tidy up data
melted_data <- melt(all_data, id=c("subjectID","Activity_Label"))
tidy_data <- dcast(melted_data, subjectID+Activity_Label ~ variable, mean)

#Ensure only mean or std gets output
tidy_data <- tidy_data[, c(which(names(tidy_data) == c("subjectID", "Label_of_Act", "ID_of_Act")), grep("mean|std", names(tidy_data)))]

write.table(tidy_data, file = "tidy_data.txt") 
