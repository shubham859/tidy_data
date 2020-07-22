## This R script does the following:

# Question_1: Merges the training and the test sets to create one data set.

train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
X <- rbind(train, test)

train <- read.table("train/y_train.txt")
test <- read.table("test/y_test.txt")
Y <- rbind(train, test)

train <- read.table("train/subject_train.txt")
test <- read.table("test/subject_test.txt")
Subject <- rbind(train, test)

# Question_2: Extracts only the measurements on the mean and standard deviation for each measurement.

measures <- read.table("features.txt")
selected_measures <- grep("-mean\\(|-std\\(" , measures$V2)
X <- X[, selected_measures]
names(X) <- measures[selected_measures, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# Question_3: Uses descriptive activity names to name the activities in the data set.

activity <- read.table("activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
Y[, 1] = activity[Y[ , 1], 2]
names(Y) <- "activity"

# Question_4: Appropriately labels the data set with descriptive activity names.

names(Subject) <- "subject"
final <- cbind(Subject, Y, X)
write.table(final, "tidy_data.txt")

# Question_5: Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

activities <- unique(final$activity)
subjects <- unique(final$subject)
n_cols <- dim(final)[2]
result <- data.frame(matrix(ncol = n_cols))
columns <- c("subject", "activity", names(X))
colnames(result) <- columns

for (sub in subjects) {
    for (activity in activities) {
        row <- c(sub, activity)
        for (variable in names(X)) {
            data <- final[final$subject == sub & final$activity == activity, variable]
            x <- mean(data)
            row <- append(row, x)
        }
        result <- rbind(result, row)
    }
}
result <- result[-1, ]
write.table(result, "tidy_data_with_means.txt")

