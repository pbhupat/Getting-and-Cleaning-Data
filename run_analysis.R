library(plyr)
# Train set
x_train <- read.table("/Pranjali R/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Pranjali R/UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("/Pranjali R/UCI HAR Dataset/train/subject_train.txt")

# Test set
x_test <- read.table("test/X_test.txt")  
y_test <- read.table("test/y_test.txt")  
sub_test <- read.table("test/subject_test.txt") 

# Read features and activities
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

#1 Merge the datasets
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train,y_test)
sub_data <- rbind(sub_train,sub_test)

main_data <- cbind(x_data,y_data,sub_data)

#4 labelling the dataset
colnames(main_data) <- c("subject", features[, 2], "activity")

#2 Extracts measurements on the mean and standard deviation 
cols <- grepl("subject|activity|mean|std", colnames(main_data))
extract <- main_data[, cols]

#3 Adding descriptive activity names
main_data$activity <- factor(main_data$activity, activities[,1],
                             activities[,2])

#5 Average of each variable for each activity and subject

avg_data <- ddply(main_data, .(subject, activity),
                  function(x) colMeans(x[, 1:66]))

write.table(avg_data, file="tidy.txt", row.names = FALSE)
