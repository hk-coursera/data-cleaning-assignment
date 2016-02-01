library(dplyr) 

get_dir_data <- function(datasetDir, scrDir, activity_labels) {
  df <- read.table(file.path(datasetDir, scrDir, paste0("X_", scrDir, ".txt")), header=FALSE)
  df$SubjectId <- read.table(file.path(datasetDir, scrDir, paste0("subject_", scrDir, ".txt")), header=FALSE, sep=" ")$V1
  df$ActivityId <- read.table(file.path(datasetDir, scrDir, paste0("y_", scrDir, ".txt")), header=FALSE, sep=" ")$V1
  full_join(df, activity_labels)
}

get_trg_features <- function(datasetDir) {
  features <- read.table(file.path(datasetDir, "features.txt"), header=FALSE, sep=" ", col.names = c("FeatureId", "Feature"))
  res = features[grep("(\\-mean\\(\\))|(\\-std\\(\\))", features$Feature),]
  res$Feature <- gsub("\\(\\)", "", res$Feature)
  res$Feature <- gsub("-", ".", res$Feature)
  res
}

get_processed_data <- function(datasetDir) {
  trg_features <- get_trg_features(datasetDir)

  activity_labels <- read.table(file.path(datasetDir, "activity_labels.txt"), header=FALSE, sep=" ", col.names = c("ActivityId", "Activity"))

  dt_test <- get_dir_data(datasetDir, "test", activity_labels)
  dt_train <- get_dir_data(datasetDir, "train", activity_labels)

  df <- bind_rows(dt_test, dt_train)

  df <- select(df, one_of(c(colnames(df)[trg_features$FeatureId], "SubjectId", "Activity")))

  colnames(df) <- c(sapply(trg_features$Feature, as.character), "SubjectId", "Activity")

  select(df, Activity, SubjectId, everything())
}

summarize_processed_data <- function(df) {
  features <- colnames(df)[colnames(df)!="SubjectId" & colnames(df)!="Activity"]
  # group_by in dplyr currently can"t group by multiple columns
  grp_dots <- lapply(c("Activity", "SubjectId"), as.symbol)
  grouped <- group_by_(df, .dots=grp_dots)
  summarise_each(grouped, funs(mean), one_of(features))
}

run_analysis <- function(datasetDir="UCI HAR Dataset", processedFilename="processed_data.csv", summarizedFilename="summarized_data.csv") {
  df <- get_processed_data(datasetDir)
  write.csv(df, processedFilename, row.names=FALSE)

  summarized <- summarize_processed_data(df)
  write.csv(summarized, summarizedFilename, row.names=FALSE)

  df
}

run_analysis()
