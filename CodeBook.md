# Code Book

This code book contains for the given dataset.

1. The downloaded dataset is extracted into the the "UCI HAR Dataset" folder in the same working directory as the source "run_analysis.R" script.

2. Variables are created from the data:
   - activities = activity_labels.txt
   - features = features.txt
   - subject_test = subject_test.txt
   - subject_train = subject_train.txt
   - x_test = X_test.txt
   - x_train = X_train.txt
   - y_test = y_test.txt
   - y_train = y_train.txt

3. Data tables are merged leading to 1 complete data set.
   - xVal = merge of x_test and x_train data tables
   - yVal = merge of y_test and y_train data tables
   - subject = merge of subject_test and subject_train data tables
   - mdata = merge of subject, xVal and yVal data tables

4. Create a new data table containing only the subject column, code column, and any columns containing the word "mean" or "std" in the name.

5. Activity code in finalData table replaced with the activity name from the activities data table.

6. Column headings in finalData table changed to more meaningful terms:
   - Column 1 renamed "Code"
   - Column 2 renamed to "Activity"
   - Any instance of "Acc" in column name replaced with "Accelerometer"   
   - Any instance of "angle" in column name replaced with "Angle"   
   - Any instance of "BodyBody" in column name replaced with "Body"
   - Any instance of "-freq()" in column name replaced with "Frequency"
   - Any instance of "gravity" in column name replaced with "Gravity"   
   - Any instance of "Gyro" in column name replaced with "Gyroscope"
   - Any instance of "Mag" in column name replaced with "Magnitude"
   - Any instance of "-mean()" in column name replaced with "Mean"
   - Any instance of "-std()" in column name replaced with "STD"
   - Any column name starting "f" replaced with "Frequency"
   - Any column name starting "t" replaced with "Time"

7. Final dataset called independent created and written to text file. Shows mean of each variable grouped by subject and activity.
