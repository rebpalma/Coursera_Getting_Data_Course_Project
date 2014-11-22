
##GETTING AND CLEANING DATA - NOVEMBER 2014

###CODE BOOK FOR THE COURSE PROJECT

###Author: Rebeca Palma Polo

----

Summary of this Code Book:

(1) GOALS OF THIS EXERCISE

(2) INFORMATION ABOUT THE ORIGINAL DATA SET

(3) INFORMATION ABOUT THE TIDY DATA SET

(4) FINAL NOTE ON UNITS OF MEASUREMENT

----

### (1) GOALS OF THIS EXERCISE

The aim of this course project is to download the information provided in the "Human Activity Recognition Using Smartphones Data Set" (available here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), combine the data sets in an appropiate manner, extract the relevant information, tidy up the resulting data table and upload to Github this new data set as a txt file.

### (2) INFORMATION ABOUT THE ORIGINAL DATA SET

A full description of the original datasets is available at the site where the data were obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This is an excerpt from the "README.txt" file that is included in the compressed folder "Dataset.zip":

_._._._._._._._._._._._._._._._

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

_._._._._._._._._._._._._._._._

##(3) INFORMATION ABOUT THE TIDY DATA SET

In the exercise, we were asked to create one R script called run_analysis.R that does the following:

* Merges the training and test sets into a single data set.

* Selects only the measurements on the mean and standard deviation for each measurement. 

* Uses descriptive activity names for the activities in the data set.

* Appropriately labels the data set columns with descriptive variable names.

* From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

And finally, upload the tidy data set created in step 5 of the instructions. The data set must be uploaded as a txt file created with write.table() and using row.name=FALSE.

####(3.1) TRANSFORMATIONS PERFORMED TO THE ORIGINAL DATA

Using R i386 3.1.2 and RStudio 0.98.507, the following operations were performed:

- Download and unzip the file "Data.zip"

- For step 1, I loaded the files '/train/X_train.txt', '/train/y_train.txt' and '/train/subject_train.txt' as data frames and applied the funcion cbind.data.frame() to bind the three of them by column. These are the training data. Then I repeated this operation to the three files '/test/X_test.txt', '/test/y_test.txt' and '/test/subject_test.txt'. These are the test data. Finally, I pasted together the training and test data usind rbind().

- For step 2, I used the "sqldf" package to select only those columns that have the strings "mean" or "std" in their names.

- For step 3, I used the "sqldf" package to add an extra column named "activity_name" to the data set resulting from step 2. This was done by joining the data set from step 2 with the loaded file  '/activity_labels.txt' using the field "activity_label" for the join.

- For step 4, I loaded the dictionary '/features.txt', filtered it and kept only the names that corresponded to the variables selected in step 2. Then assigned this vector to the names() vector of the data set of step 3, in order to substitute the variable names "V1", "V2", etc. of the data set of step 3 with more meaningful names.

- For step 5, I first used the funtion ddply() from package "plyr" to group the data by subject and activity, and apply colMeans to the columns. Then I used the function gsub() to remove the characters "(", ")" from the names of the variables, substitute "-" for "_" and substitute "," for "_".

- Finally, I saved the resulting tidy data set as the text file "tidy_data.txt" using write.table() and row.name=FALSE as requested.

####(3.2) DESCRIPTION OF THE DATA

The file tidy_data.txt contains 180 rows and 88 columns.
In each row in the text file, for each of the 30 participants (column 1), and for each activity that the subject performed (column 2), we can observe the average measurement achieved in each of the 86 variables that are either a mean or a standard deviation of the original measurements of the experiment (columns 3 to 88).


####(3.3) DESCRIPTION OF THE VARIABLES

Column 1: Variable "subject" -> identifies the subject who performed the activity for each window sample. Its values range from 1 to 30.

Column 2: Variable "activity_name" -> each of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) that each person performed wearing a smartphone (Samsung Galaxy S II) on the waist.

Columns 3 to 88: Means and standard deviations of the original measurements in the experiment. Only those variables with the strings "mean" or "std" in their names were selected.
The original features were normalized and bounded within [-1,1].
These are the 86 variables selected and then aggregated to show the average per subject and activity:
 
3 -> tBodyAcc_mean_X	   
4 -> tBodyAcc_mean_Y	   
5 -> tBodyAcc_mean_Z	   
6 -> tBodyAcc_std_X	   
7 -> tBodyAcc_std_Y	   
8 -> tBodyAcc_std_Z	   
9 -> tGravityAcc_mean_X	   
10 -> tGravityAcc_mean_Y	   
11 -> tGravityAcc_mean_Z	   
12 -> tGravityAcc_std_X	   
13 -> tGravityAcc_std_Y	   
14 -> tGravityAcc_std_Z	   
15 -> tBodyAccJerk_mean_X	   
16 -> tBodyAccJerk_mean_Y	   
17 -> tBodyAccJerk_mean_Z	   
18 -> tBodyAccJerk_std_X	   
19 -> tBodyAccJerk_std_Y	   
20 -> tBodyAccJerk_std_Z	   
21 -> tBodyGyro_mean_X	   
22 -> tBodyGyro_mean_Y	   
23 -> tBodyGyro_mean_Z	   
24 -> tBodyGyro_std_X	   
25 -> tBodyGyro_std_Y	   
26 -> tBodyGyro_std_Z	   
27 -> tBodyGyroJerk_mean_X	   
28 -> tBodyGyroJerk_mean_Y	   
29 -> tBodyGyroJerk_mean_Z	   
30 -> tBodyGyroJerk_std_X	   
31 -> tBodyGyroJerk_std_Y	   
32 -> tBodyGyroJerk_std_Z	   
33 -> tBodyAccMag_mean	   
34 -> tBodyAccMag_std	   
35 -> tGravityAccMag_mean	   
36 -> tGravityAccMag_std	   
37 -> tBodyAccJerkMag_mean	   
38 -> tBodyAccJerkMag_std	   
39 -> tBodyGyroMag_mean	   
40 -> tBodyGyroMag_std	   
41 -> tBodyGyroJerkMag_mean	   
42 -> tBodyGyroJerkMag_std	   
43 -> fBodyAcc_mean_X	   
44 -> fBodyAcc_mean_Y	   
45 -> fBodyAcc_mean_Z	   
46 -> fBodyAcc_std_X	   
47 -> fBodyAcc_std_Y	   
48 -> fBodyAcc_std_Z	   
49 -> fBodyAcc_meanFreq_X	   
50 -> fBodyAcc_meanFreq_Y	   
51 -> fBodyAcc_meanFreq_Z	   
52 -> fBodyAccJerk_mean_X	   
53 -> fBodyAccJerk_mean_Y	   
54 -> fBodyAccJerk_mean_Z	   
55 -> fBodyAccJerk_std_X	   
56 -> fBodyAccJerk_std_Y	   
57 -> fBodyAccJerk_std_Z	   
58 -> fBodyAccJerk_meanFreq_X	   
59 -> fBodyAccJerk_meanFreq_Y	   
60 -> fBodyAccJerk_meanFreq_Z	   
61 -> fBodyGyro_mean_X	   
62 -> fBodyGyro_mean_Y	   
63 -> fBodyGyro_mean_Z	   
64 -> fBodyGyro_std_X	   
65 -> fBodyGyro_std_Y	   
66 -> fBodyGyro_std_Z	   
67 -> fBodyGyro_meanFreq_X	   
68 -> fBodyGyro_meanFreq_Y	   
69 -> fBodyGyro_meanFreq_Z	   
70 -> fBodyAccMag_mean	   
71 -> fBodyAccMag_std	   
72 -> fBodyAccMag_meanFreq	   
73 -> fBodyBodyAccJerkMag_mean	   
74 -> fBodyBodyAccJerkMag_std	   
75 -> fBodyBodyAccJerkMag_meanFreq	   
76 -> fBodyBodyGyroMag_mean	   
77 -> fBodyBodyGyroMag_std	   
78 -> fBodyBodyGyroMag_meanFreq	   
79 -> fBodyBodyGyroJerkMag_mean	   
80 -> fBodyBodyGyroJerkMag_std	   
81 -> fBodyBodyGyroJerkMag_meanFreq	   
82 -> angletBodyAccMean_gravity	   
83 -> angletBodyAccJerkMean_gravityMean	   
84 -> angletBodyGyroMean_gravityMean	   
85 -> angletBodyGyroJerkMean_gravityMean	   
86 -> angleX_gravityMean	   
87 -> angleY_gravityMean	   
88 -> angleZ_gravityMean	 


From the 'features_info.txt' file contained in the 'Dataset.zip" we obtain the following information regarding the meaning of the names of the variables:

_._._._._._._._._._._._._._._._

Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

_._._._._._._._._._._._._._._._

###(4) FINAL NOTE ON UNITS OF MEASUREMENT

As described in the file 'README.txt' of the original dataset in 'Dataset.zip':

- The acceleration signal from the smartphone accelerometer X axis is measured in standard gravity units 'g'. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- The angular velocity vector is measured by the gyroscope for each window sample, and the units are radians/second.
- After that, features are normalized and bounded within [-1,1], hence they become non-dimensional.

Averaging these variables to form the final tidy data set does not change the units of measurement, hence they stay non-dimensional. 

