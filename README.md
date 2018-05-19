# Getting-and-Cleaning-Data-Course-Project

This is a course project for the "Getting and Cleaning Data" course of the "Data Science Specialization by JHU" offered on Courera. 

Details of the problem statement can be found at the following link -> https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project

The R script`run_analysis.R` present in this repository does the following:

1. Reads the "subject data", "training dataset", "activity data" from the working directory where the zip files have 
   been extracted.
2. Reads the "features data" , assigns the column names to the above datasets and then merges them all.
3. Does steps 1 & 2 to the test dataset as well
4. Merges the training and test datasets obtained from the above, keeping only those columns which reflect a mean or 
   standard deviation
5. Appropriately labels the data set with descriptive variable names
6. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The final tidy dataset is stored as `tidy.txt`.
