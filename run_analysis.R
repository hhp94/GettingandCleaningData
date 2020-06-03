# Run the following scripts to load the needed libraries:
rm(list=ls())

install_function<- function(x){
        list.of.packages <- x
        new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
        if(length(new.packages)) {install.packages(new.packages)}
}
x<-c("tidyverse", "janitor","data.table")

install_function(x)

library("tidyverse")
library("janitor")
library("data.table")

# I. Reconstruct a full data frame from the "test" and "train" data set with the subjects ID and activity Ids 
        # Step 1: Reconstruct "train" datasets
        train<-fread("./UCI HAR Dataset/train/X_train.txt")                     #read X_train
        train_subjects<-fread("./UCI HAR Dataset/train/subject_train.txt")      #read subject ID
        train_activities<-fread("./UCI HAR Dataset/train/y_train.txt")          #read activities ID
        train_full<- train %>% bind_cols(train_subjects, train_activities) %>%  #merge the three. 
                as_tibble

        
        # Step 2: Reconstruct "test" datasets
        test<-fread("./UCI HAR Dataset/test/X_test.txt")                        #read_ X_test
        test_subjects<-fread("./UCI HAR Dataset/test/subject_test.txt")         #read subject ID
        test_activities<-fread("./UCI HAR Dataset/test/y_test.txt")             #read activities ID
        test_full<- test %>% bind_cols(test_subjects, test_activities) %>%      #merge the three
                as_tibble

        # Step 3: Merge "train" and "test" datasets
        merged<-full_join(train_full, test_full) %>%                            #results: a 563 columns data frame. the first 561
                 as_tibble                                                      #columns are given, column 562 is the subject Ids
        head(merged)                                                            #and column 563 is activities IDs

        # Step 4: Contruct the "label" dataset to name the full dataset.
        row562<-"subject"                                                       #create a label called "subject" which     
        names(row562) <- "V2"                                                   #contains subject IDs

        row563<-"activity"                                                      #create a label called "activities" which 
        names(row563)<- "V2"                                                    #contains activity IDs

        labels<-fread("./UCI HAR Dataset/features.txt")                           #import the labels of the first 561 columns
        labels <- labels %>% 
        select(-V1, V2) %>%
        bind_rows(row562,row563) %>%                                            #add "subject" and "activities" to the labels
                as_tibble
        
        head(labels)                                                            #results: a length of 563 vectors contains labels. 
        tail(labels)

        # Step 5: Apply the label to the merged full dataset
        names(merged) <- labels$V2
        merged<-clean_names(merged)                                             #clean_names: converted all names to lower case,
                                                                                #converted special characters into "_", and assigned numbers
                                                                                #if there are duplicated names
        head(names(merged))
        tail(names(merged))
        
        # Step 6: get the activity labels:
        act_labels<- fread("./UCI HAR Dataset/activity_labels.txt")
        act_labels<- data.frame(V1 = act_labels$V1, V2= tolower(act_labels$V2)) %>%
                as_tibble
                        
        # Step 7: convert "activity" and "subjects" to named factors: 
        merged<- merged %>% 
                mutate(activity_f = factor(activity, levels = act_labels$V1, labels = act_labels$V2)) %>%
                mutate(subject_f = factor(subject)) 
        
        #At the end of step 7, we have a full dataset from "test" and "train" folder, with subject IDs and named activity IDs
        
# II. Extracts only the measurements on the mean and standard deviation for each measurements
        mean_all<- t(merged %>% select(-(subject:subject_f)) %>%
                          summarize(across(1:561, mean)))
        sd_all<- t(merged %>% select(-(subject:subject_f)) %>%
                           summarize(across(1:561, sd)))
        head(mean_all)
        tail(mean_all)
        
        head(sd_all)
        tail(sd_all)
        
# III. Use descriptive activity names to name the activities in the dataset:
        #This step has already been performed in first part. The column "activity_f" in data frame "merged" 
        #provides the activity names:
        
        head(merged$activity_f, n = 10)
        tail(merged$activity_f, n = 10)
        
# IV. Appropriately labels the data set with descriptive variable names:
        #The variable names has already been cleaned up in part I, Step 5 with the function janitor::clean_names().
        #This function converted all names to lower case, all special characters into "_", and duplicated names are assigned with numbers
        #at the end to make them unique. 
        #The results are names are descriptive and unique, and legible.
        
        head(names(merged),n =50)
        tail(names(merged),n =50)
        
        #This tests if the names of the variables are unique:
        length(unique(names(merged))) # equals to 565 which is the number of variables in our dataset 
        
# V. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity,
# and each subject. 
        
        #WARNING: THIS CODE WILL TAKE A WHILE TO PERFORM.
        final_df<- merged %>% 
                group_by(activity_f, subject_f) %>%
                summarize(across(1:561,mean))                   
        head(final_df)
        #Final Results: tidy df (180x561). This is the correct dimension because we have 6 activities * 30 people =180 rows, and 561
        #columns for 561 variables. 

# VI. Write the data to disk
        #Final data table
        write_csv(final_df, path = "./tidy_df.csv",append = FALSE,col_names = TRUE)
        write_delim(final_df, path = "./tidy_df.txt", delim = " ",append = FALSE,col_names = TRUE) 
        #Label list:
        tidy_df_labels<-bind_cols(Number = 1:length(names(final_df)), Variables = names(final_df))
        write_csv(tidy_df_labels, path = "./tidy_df_labels.csv", append = FALSE, col_names = TRUE)
        write_delim(tidy_df_labels, path = "./tidy_df_labels.txt", delim = " ", append = FALSE, col_names = TRUE)
