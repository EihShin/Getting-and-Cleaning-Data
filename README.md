# Getting-and-Cleaning-Data

Here is the course project of Getting and Cleaning Data Coursera course. The run_analysis.R does the following:

1)Load the subject, X and Y .txt from train and test file data after downloaded from web.  
2)Load the activity and feature .txt.  
3)Extract features those containing "mean" and "std".  
4)Bind the columns of subject, X and Y for train and test data and get 2 new and tidy train and test data.  
5)Bind the rows of new train and test data to become one set data.  
6)Aggregate the variables in mean by subject and activity.  
7)Exclude undefined columns, then merge activity .txt and aggegated data in order to get the labels of activity name.  
8)Write the last result dataset to tidy .txt.   
