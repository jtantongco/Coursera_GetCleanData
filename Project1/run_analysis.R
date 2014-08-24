if(!file.exists("UCI HAR Dataset"))
        unzip("getdata-projectfiles-UCI HAR Dataset.zip")

setwd('./UCI HAR Dataset')

#Quiet suppress/enables command output
#what='' also acceptable - controls how the output will be read and interpreted
features <- scan("features.txt", what="c",sep="\n",quiet=F)
#head(features)

#Make a decision list based on a regex that has a mean or std in the name
#repl returns regex true or false patter matching result
meanNStdOnly <- grepl("mean|std", features)
#head(meanNStdOnly)

#Remove unecessary column types
meanNStdFeatures <- features[meanNStdOnly]
#length(meanNStdFeatures)

#sub takes the pattern match and replaces it with the specified text
#Remove the first (up to three) numbers and space
meanNStdFeatures <- gsub("^[0-9]+[ ]","",meanNStdFeatures)
#Remove the () and the  -
meanNStdFeatures <- gsub("\\(\\)","",meanNStdFeatures)
meanNStdFeatures <- gsub("^t","time_",meanNStdFeatures)
meanNStdFeatures <- gsub("^f","freq_",meanNStdFeatures)
#meanNStdFeatures

#Make a decision variable list regarding the type of all the variables
#only the ones we are interested should be numeric, null for everything else
#like sapply buy will allow additional arguments to the function
filter <- mapply(ifelse, meanNStdOnly, "numeric", "NULL")
#length(colFilter)

#as.is -> let the type of the data read be interpreted as opposed to becoming all characters
activitiesLabels <- read.table("activity_labels.txt", as.is=T, col.names=c("activity_id","activity"))
#head(activitiesLabels)

activities <- activitiesLabels$activity

#read in the test data
setwd("./test")
testData <- read.table("X_test.txt", colClasses=filter)
testSubject <- read.table("subject_test.txt")
testActivityID <- read.table("y_test.txt", col.names = "activityID")
testActivity <- list(activity=activities[testActivityID$activityID])

#read in the training data
setwd("../train")
trainData <- read.table("X_train.txt", colClasses=filter)
trainSubject <- read.table("subject_train.txt")
trainActivityID <- read.table("y_train.txt", col.names = "activityID")
trainActivity <- list(activity=activities[trainActivityID$activityID])

setwd("..")

#merge the data
tidyData <- as.data.frame(
        rbind( # rows from training data and test data
                cbind(trainSubject, trainActivity, trainData), # columns from subject, activity, measurements
                cbind(testSubject, testActivity, testData)
        ))
names(tidyData) = c("VolunteerID","Activity", meanNStdFeatures)

#attach(tidyData)
#aggData <- aggregate(tidyData, by=list(VolunteerID,Activity), FUN=mean, na.rm=TRUE) 
#generates an error on multiple runnings [due to the attach]

#Seems to work but generates a row of NAs
#aggData <- aggregate(tidyData, by=list(tidyData$VolunteerID, tidyData$Activity), FUN=mean)
#unique(aggData[,4])

#Remove the two group columns that are the grouping named columns
aggData <- aggregate(x=tidyData[,3:81], by=list(tidyData$VolunteerID, tidyData$Activity), FUN=mean)

#add the names again since the first two columns have been renamed group 1 and group 2
names(aggData) = c("VolunteerID","Activity", meanNStdFeatures)
#head(aggData)

setwd("..")

write.table(aggData,"aggregate_data.txt", row.name=FALSE)

