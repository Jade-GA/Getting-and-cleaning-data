The run_analysis.R script performs the following

1 Merges the training and the test sets to create one data set.
  Downloads and unzips the dataset.
  Reads test data and training data and labels.
  Merges all data to form complete_data


2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
  Every Acc in column’s name  is replaced by Accelerometer.
  Every Gyro in column’s name replaced by Gyroscope.
  Every BodyBody in column’s name replaced by Body.
  Every Mag in column’s name replaced by Magnitude.
  Every column’s name that starts with f is replaced by Frequency.
  Every column’s name that starts with t is replaced by Time

5.Creates a second, independent tidy data set. It contains the average of each variable for each activity and each subject.
  Makes a tidy data set called Final_data.
  Writes the tidy data set in a txt file.


