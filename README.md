I. Structure: 
This repo contains all the files submitted for the assignment of the Coursera Course: "Cleaning and Getting Data"

The submitted files are as follows:
1) The main script: [run_analysis.R](./run_analysis.R)
2) The final dataset: [tidy_df.txt](./tidy_df.txt)
3) The full label list of the dataset: [tidy_df_labels.txt](./tidy_df_labels.txt)
4) The Code Book: [CodeBook.md](./CodeBook.md)

II. How the script works:
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
