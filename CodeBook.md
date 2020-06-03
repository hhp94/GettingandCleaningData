I. Introduction:
The "tidy_df" is a 180*563 tidy data frame that summarizes the mean of the original 561 variables across two strata: 1) activities ("walking", "walking_upstairs", "walking_downstairs", "sit
ting","standing" and "laying") and 2) subject IDs (1:30). 

II. Variables:
The variables included in this dataset are the original 561 variables of the provided dataset,
plus the two additional variables: "activity_f" and "subject_f" that describes the activities,
and subject IDs invovled. The 561 variables are copied from the file [features_info.txt](./UCI HAR Dataset/features_info.txt). The full list of variables can be found in [tidy_df_labels.csv](./UCI HAR Dataset/tidy_df_labels.csv). 

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

III. Data transformation:   
Step 1: Add the "subject ID" and "activities ID" to the "test" and "train" dataset   
Step 2: Row bind the test and train dataset into one dataset called "merged"  
Step 3: Create a vector of length 561 from the full [features.txt](./UCI HAR Dataset/features_info.txt) file  
Step 4: Row bind two rows called "subject" and activity to the label vector, resulting in a length 563 vector  
Step 5: Assigned the name of the "merged" dataset with the label vector.  
Step 6: Clean the names of the variables by using the function clean_names() which transform all special
characters into "_" and spaces into "_".   
Step 7: Imported the list of activities in the file [activity_labels.txt](./UCI HAR Dataset/activity_labels.txt)  
Step 8: Create a new column in the merged dataset called "activity_f" by transforming   
the "activity" column transformed into factors, with the levels and labels assigned according to the imported list.  
Step 9: Create a new column in the merged dataset called "subject_f" by transforming  
the "subject" column into factors  
Step 10: Construct the tidy_df by using dplyr functions: summarize() and accross()  
