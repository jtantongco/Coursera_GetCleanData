# Coursera: Getting and Cleaning Data Peer Assessment Submission

# codebook.md

## columns:

### VolunteerID

The ID of a volunteer who generated the user data. 
These are integers ranging from 1 to 30.

### Activity

The activity that the data corresponds to.
There are six possible string values for this column.

* "LAYING"
* "SITTING"
* "STANDING"
* "WALKING"
* "WALKING_DOWNSTAIRS"
* "WALKING_UPSTAIRS"
 
### Other Columns

These are summary data measurements from the UCI HAR Dataset in the X_train.txt and X_test.txt files in the original data sets.
They contain various measurements taken from onboard sensors on a Samsung phone.

To see more details on the original dataset, please refer to the following link:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original data set can be downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Transformations:

The following were done to go from the raw data set to the current tidy aggregate data:

* filtering out columns that did not have the word mean or std in the columne name
* joins to match up the volunteer id and the activity with the phone data.
* merging the test data set with the training data set
* after merging, summary mean statistics were calculated and reported in aggregate_data.txt

## Relabeling: 

The following were done to relabel the raw data set to the current tidy aggregate data:

* the leading one, two or three digit number and space were removed as they only corresponded to the number of lines in the data file 
* parenthesis ( "()" ) in column names were removed
* hyphens ( "-" ) in column names were replaced with underscores ( "_" )
* columns with a prefix of "t" were replaced with a prefix of "time_" 
* columns with a prefix of "f" were replaced with a prefix of "freq_"

An example transformation can be seen here with the above rules:

"6 tBodyAcc-std()-Z" -> "time_BodyAcc_std_Z"