#####################################################
GETTING AND CLEANING DATA - NOVEMBER 2014
README.md FILE FOR THE COURSE PROJECT
Author: Rebeca Palma Polo
#####################################################

The aim of this course project is to download the information provided in the "Human Activity Recognition Using Smartphones Data Set" (available here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), combine the data sets in an appropiate manner, extract the relevant information, tidy up the resulting data table and upload to Github this new data set as a txt file.

The assignment consists of the production and upload to each student's Github account of the following files:

- 'run_analysis.R' ->  R script that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Store the tidy data set in a txt file called 'tidy_data.txt' with write.table() using row.name=FALSE

- 'tidy_data.txt' -> the tidy data set obtained in step 6 of the script mentioned above.

- 'CodeBook.md' -> a code book that describes the variables, the data, and the transformations that I performed to clean up the data.

- 'README.md' -> this document. Please refer to 'CodeBook.md' for information on how the original data files were combined and how the analysis was performed.



License:
========
The original dataset used for this exercise has been taken from the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

For more information about this dataset contact: activityrecognition@smartlab.ws

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012. 
