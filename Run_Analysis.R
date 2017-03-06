URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download_file <- download.file(URL, destfile = "C:\\Users\\kbec\\Desktop\\Data Sets\\Data_Ass2.zip")

# Opening Training Data Information
X_TRAIN <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\train\\X_train.txt")
Y_TRAIN <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\train\\y_train.txt")
SUBJECT_TRAIN <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\train\\subject_train.txt")
FEATURES <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\features.txt")

str(X_TRAIN)


# Opening Testing Data Information
X_TEST <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\test\\X_test.txt")
Y_TEST <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\test\\y_test.txt")
SUBJECT_TEST <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\test\\subject_test.txt")
FEATURES <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\features.txt")

# Assign Training column labels
names(X_TRAIN) <-  make.names(FEATURES$V2) 
names(Y_TRAIN) <- "Activity.ID"
names(SUBJECT_TRAIN) <- "Subject.Label"

# Assign Testing column labels
names(X_TEST) <- make.names(FEATURES$V2)
names(Y_TEST) <- "Activity.ID"
names(SUBJECT_TEST) <- "Subject.Label"

# Activity Labels
Activity_Labels <- read.table("C:\\Users\\kbec\\Desktop\\Getting Data\\Assignment 2\\activity_labels.txt")
names(Activity_Labels) <- c("Activity.ID", "Activity.Label")

# Merging Data
Merged_training_Data <- cbind(X_TRAIN, SUBJECT_TRAIN, Y_TRAIN)
Merged_Testing_Data <- cbind(X_TEST, SUBJECT_TEST, Y_TEST)
Data_Set <- rbind(Merged_training_Data,Merged_Testing_Data)

Column_Names <- names(Data_Set)

names(Data_Set)


#Filtering Columns
Mean_STD <- (grepl("Activity.ID", Column_Names) |
             grepl("Subject.Label", Column_Names) |
             grepl("mean", Column_Names) |    
             grepl("std", Column_Names) 
             )


Data_Set_Mean_STD <- Data_Set[,Mean_STD == TRUE]

#Activity ID Merge
Activity_Names_DS <- merge(Data_Set_Mean_STD, Activity_Labels, by="Activity.ID", all.x=TRUE)
names(Activity_Names_DS)

#Second Average Tidy Data Set
Tidy_DS <- aggregate(.~Subject.Label + Activity.ID, Activity_Names_DS, mean)
Tidy_DS_Ordered <- Tidy_DS[order(Tidy_DS$Subject.Label, Tidy_DS$Activity.ID),]

#Export Tidy Data Set
Tidy_DS <- write.table(Tidy_DS_Ordered,"C:\\Users\\kbec\\Desktop\\Getting Data\\Tidy.txt")




grep
