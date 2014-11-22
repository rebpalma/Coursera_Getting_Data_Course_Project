# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that can be 
# used for later analysis. You will be graded by your peers on a series of yes/no 
# questions related to the project. You will be required to submit: 1) a tidy 
# data set as described below, 2) a link to a Github repository with your script 
# for performing the analysis, and 3) a code book that describes the variables, 
# the data, and any transformations or work that you performed to clean up the 
# data called CodeBook.md. You should also include a README.md in the repo with 
# your scripts. This repo explains how all of the scripts work and how they are 
# connected.  

###############################################################################

# Start of code:

# Here are the data for the project: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This scripts needs the following packages installed before proceeding:
# install.packages ("sqldf")
# install.packages ("plyr")

## You should create one R script called run_analysis.R that does the following:

###############################################################################
# STEP 1: Merge the training and the test sets to create one data set.

# First we download the zipped data from the web into our working directory.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip")

# Now we unzip the data we have just downloaded:
unzip("Dataset.zip")

#As a result we get the unzipped folder "UCI HAR Dataset" in our working directory.

#-------------------------#

# Now we load the unzipped files on to R, one by one:
currentdir<-getwd()

# From the folder "/UCI HAR Dataset/train":
X_train_str <- paste(currentdir,"UCI HAR Dataset/train/X_train.txt", sep="/")
training_set<-read.table(X_train_str)
# dim(training_set)
# [1] 7352  561
# head(training_set)
# 7352 observations (rows) from 30 individuals and of 561 variables (columns). 
# These columns are named V1, ..., V561, but their actual names can be found
# in the file "UCI HAR Dataset/features.txt"

Y_train_str <- paste(currentdir,"UCI HAR Dataset/train/y_train.txt", sep="/")
training_labels<-read.table(Y_train_str) 
# The dictionary for these labels is the file "UCI HAR Dataset/activity_labels.txt"

subject_train_str <- paste(currentdir,"UCI HAR Dataset/train/subject_train.txt", sep="/")
subject_train<-read.table(subject_train_str)

# We attach these three data.frames by column to obtain the whole data for the 
# "/UCI HAR Dataset/train" folder.

train_folder_df<-cbind.data.frame(training_set, subject_train,training_labels )
names(train_folder_df)<-c( names(training_set), "subject","activity_labels")


#-------------------------#

# From the folder "/UCI HAR Dataset/test":
X_test_str <- paste(currentdir,"UCI HAR Dataset/test/X_test.txt", sep="/")
test_set<-read.table(X_test_str)

Y_test_str <- paste(currentdir,"UCI HAR Dataset/test/y_test.txt", sep="/")
test_labels<-read.table(Y_test_str) #The dictionary for these labels is the file "UCI HAR Dataset/activity_labels.txt"

subject_test_str <- paste(currentdir,"UCI HAR Dataset/test/subject_test.txt", sep="/")
subject_test<-read.table(subject_test_str)

# We attach these three data.frames by column to obtain the whole data for the 
# "/UCI HAR Dataset/test" folder.

test_folder_df<-cbind.data.frame(test_set, subject_test,test_labels )
names(train_folder_df)<-c( names(test_set), "subject","activity_labels")

#-------------------------#

# From the main folder "/UCI HAR Dataset":

# Dictionary table for activity labels:
act_label_dictionary_str <- paste(currentdir,"UCI HAR Dataset/activity_labels.txt", sep="/")
act_label_dictionary<-read.table(act_label_dictionary_str)

# Dictionary table for names of 561 variables V1, ..., V561
varnames_dictionary_str <- paste(currentdir,"UCI HAR Dataset/features.txt", sep="/")
varnames_dictionary<-read.table(varnames_dictionary_str)

#-----------------------------#
# Finally, we end up with 4 tables to work with:
# dim(train_folder_df)
# [1] 7352  563
# dim(test_folder_df)
# [1] 2947  563
# dim(act_label_dictionary)
# [1] 6 2
# dim(varnames_dictionary)
# [1] 561   2

# We paste together the training and test data:
names(test_folder_df)<-names (train_folder_df)
data_raw<-rbind(train_folder_df,test_folder_df)

# And data_raw completes step 1.

###############################################################################

# STEP 2: Extract only the measurements on the mean and standard deviation 
# for each measurement. 

# This question is open to interpretation, so from the data.frame "data_raw"
# I will select those variables that have the strings "mean" or "std" in their names.

library("sqldf")
selected_varnames<-sqldf("select * from varnames_dictionary where ((V2 like ('%mean%')) or (V2 like'%std%'))")

data_raw2<-data_raw[,c( selected_varnames[,1], 562, 563)]

# And data_raw2 completes step 2.

###############################################################################

# STEP 3: Use descriptive activity names to name the activities in the data set.
# This can be achieved by either adding the activity names as an extra column 
# in the "data_raw" table, or substituting them.
# I choose to add an extra column named "activity_name".
# Here is where we use act_label_dictionary.

names(act_label_dictionary)<-c("activity_labels","activity_name")

data_raw3<-sqldf("select a.*, b.activity_name as activity_name from data_raw2 a inner join act_label_dictionary b USING(activity_labels)")

# And data_raw3 completes step 3.

###############################################################################

# STEP 4: Appropriately label the data set with descriptive variable names.
# Here is where we use varnames_dictionary.

# First, we make a copy "data" of "data_raw3", so that by changing "data" we 
# don't change "data_raw3". This way, if we mess up "data", at least we still
# have stored our progress up to "data_raw3".

data<-sqldf("select * from data_raw3") # we make a copy of data_raw3

varnames_dictionary2<-varnames_dictionary[selected_varnames[,1],]

names(data)[1:length(varnames_dictionary2[,2])]<-as.character(varnames_dictionary2[,2])

# And data completes step 4.

###############################################################################

# STEP 5: From the data set in step 4, create a second, independent tidy data 
# set with the average of each variable for each activity and each subject.

# First, we make a copy of "data":
data5<-sqldf("select * from data")

# Now we group the data by the two variables and apply colMeans to the columns:

library(plyr)
dataset <- ddply(data5, .(subject, activity_name), .fun=function(x){ colMeans(x[,c(1:86)]) })

# Now we tidy up the data:
tidy_data<-dataset
names(tidy_data)<-gsub("(","", names(tidy_data), fixed=TRUE)
names(tidy_data)<-gsub(")","", names(tidy_data), fixed=TRUE)
names(tidy_data)<-gsub("-","_", names(tidy_data), fixed=TRUE)
names(tidy_data)<-gsub(","  ,   "_"   , names(tidy_data), fixed=TRUE)

# And tidy_data completes step 5.

###############################################################################

# Please upload the tidy data set created in step 5 of the instructions.
# Please upload your data set as a txt file created with write.table() using 
# row.name=FALSE (do not cut and paste a dataset directly into the text box, as 
# this may cause errors saving your submission).

write.table(tidy_data, file = "tidy_data.txt", row.name=FALSE)
