require("data.table")

#
# 1.Load data to Data table
#

# 1.1 
# Function for reading and bind data
# This func. read subject and X(feature) and Y(activity) under parentPath
# and bind it by column side and set column names.
# Especially, Y(activity) data is factorized with activity levels
loadData <- function(parentPath, type, columnNames, activityLevels) {
  subject_path <- paste0(parentPath, '/', type, '/subject_', type, '.txt')
  X_path <- paste0(parentPath, '/', type, '/X_', type, '.txt')
  Y_path <- paste0(parentPath, '/', type, '/Y_', type, '.txt')
  
  # Factorize Y value with activity names (This work makes output has characterized values)
  Y <- read.table(Y_path)
  Y$V1 <- factor(Y$V1)
  levels(Y$V1) <- activityLevels
  
  binded_data <- cbind(
    read.table(subject_path),
    read.table(X_path),
    Y
    )
  names(binded_data) <- columnNames
  
  data.table(binded_data)
}

# 1.2 load total observations from file using loadData function
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
column_names <- c('subject', features$V2, 'activity')

activity_levels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)

total_data <- rbind(
  loadData('./UCI HAR Dataset', 'test', column_names, activity_levels$V2), 
  loadData('./UCI HAR Dataset', 'test', column_names, activity_levels$V2)
  )

#
# 2.Extract mean and std columns from total_data
#
column_list_to_extract <- grep('(subject)|(mean\\(\\))|(std\\(\\))|(activity)', column_names)
extracted_data <- total_data[, .SD, .SDcols=column_list_to_extract]

#
# 3.Aggregate the column's mean for each activity and each subject
#
final_result <- extracted_data[, lapply(.SD, mean), by=c('activity', 'subject')]

#
# 4. Save Data
#
write.table(final_result, file='./SampleOutput/output.txt', row.name=FALSE)

