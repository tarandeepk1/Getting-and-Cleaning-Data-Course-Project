# Getting-and-Cleaning-Data-Course-Project

run_analysis.R script does the following. 

1. Downloads the datasets from the local directory.
2. Reads train and test datasets and merges them into x_data(measurements), y_data(activity) and subject_data
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Further it merges xdata(for mean and std dev), y data and subject data into one dataset called allData.
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive variable names. 
7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

