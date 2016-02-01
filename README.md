###Script for data cleaning course assignment.

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
* `run_analysis(datasetDir="UCI HAR Dataset", processedFilename="processed_data.csv", summarizedFilename="summarized_data.csv")`
    * Performs data cleaning using functions mentioned above and writes results in two files.

By default script writes results in two files: "processed_data.csv" and "summarized_data.csv".

Script uses some functions from dplyr package.
