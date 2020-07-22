# The script run_analysis.R performs the following steps:
    
1) Merging of train and test datasets for all X, Y and Subject datasets.

2) Updating the variable names of the resulting X dataset by filtering 
means & standard deviations of each variable in features.txt

3) Extacting and fomatting the activity labels from activity_labels.txt

4) Combining the respective observations from all X, Y and Subject datasets.
The resulting dataset is written in tidy_data.txt file.

5) Calculating and inserting the means of each subject for each activity and 
each variable. The resulting dataset is written in tidy_data_with_means.txt file.