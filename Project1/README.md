# Coursera: Getting and Cleaning Data Peer Assessment Submission

# README.md

The project folder contains:

* README.md
* run_analysis.R
* aggregate_data.txt
* codebook.md

## README.md

Readme that you are currently reading that describes the submitted artifacts.

## run_analysis.R

The R script that generates the aggregate_data.txt.
It reads the data from compressed UCI HAR dataset.
The data can be found here: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

The script selects only the data that was specified in the peer assement criteria.
Additionally, it merges datasets from both the test and training data, stored in a variable called tidyData.

The script then performs data aggregation to collect the summary statistics then storing it in the a variable called aggData.
The aggData is then outputted into aggregate_data.txt.

### Instructions:

1. download the script
2. set working directory to any folder containing the compressed data file (getdata-projectfiles-UCI HAR Dataset.zip)
3. run the script

## aggregate_data.txt

The end result of run_analysis.R.

The file contains aggregated data from the tidy data using mean statistics and grouped by volunteer and activity.

##codebook.md

A brief description of the columns found in aggregate_data.txt