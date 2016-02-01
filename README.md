###Script for data cleaning course assignment.

Script includes call of the main function (`run_analysis()`), so it will start working immediately when load it with `source`.

####The script has following functions:

* `get_trg_features(datasetDir)`
    * Returns table with names of all mean and std variables (cleaned from undesired symbols) and their column number in original dataset.
* `get_dir_data(datasetDir, scrDir, activity_labels)`
    * Returns data from directory ('test' or 'train') with added 'SubjectId', 'ActivityId' and 'Activity' columns.
* `get_processed_data(datasetDir)`
    * Returns one data frame that:
        * includes merged test and train data
        * adds 'SubjectId' and 'Activity' columns
        * includes only mean and standard deviation variables
        * renames columns with these variables to readable format
    * Uses get_trg_features and get_dir_data
* `summarize_processed_data(df)`
    * Returns data frame, where each row contains average of each variable for each activity and each subject.
* `run_analysis <- function(datasetDir="UCI HAR Dataset", summarizedFilename="tidy_summarized_dataset.txt", processedFilename="full_processed_dataset.txt")`
    * Performs data cleaning using functions mentioned above and writes results in two files.
    * Returns summarized_data.

By default script writes results in two files: "tidy_summarized_datasetset.txt" and "full_processed_dataset.txt".

Script uses some functions from dplyr package.
