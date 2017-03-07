# The purpose of the present file is to describe the variables created in the Run Analysis.R file along with it's use throught the code.


The reshape2 library is used to use the dcast function which facilitates the final melting of the data.

##Datasets
###Features an labels
"features" is the first variable created. It takes the information stored in the features.txt file, which contains most the variables of interest of the UCI Human Activity Research with its corresponding identifier. All of which comes from the sensors used to gather data and transformed somehow, like extracting the mean and std.

"activity_labels" variable is a table containing the info of the activity_labels.txt

"subject_train" contains the info of the table "subject_train.txt"
"train_set"  contains the info of the table "X_train.txt"
"train_label" contains the info of the table "y_train.txt"

"subject_test" contains the info of the table "subject_test.txt"
"test_set"  contains the info of the table "X_test.txt"
"test_label"contains the info of the table "y_test.txt"

The code then assings the second column of the features table to all test and train set (train_set and test_set).

The code then assigns the activity labels to both test and train sets.This is done be subsetting the activty_labels variables using only the column with the label, then associating those labels to the second column of both test_label and train_label data sets. The column names "ID_of_Act" and "Activity_Label" assigned to both data tables.
Column names of subject_test and subject_train are both given "subjectID". This is done symmetrically so that the variables "all_test" and "all_train" are created combining columns.
Once the cbind is done for train an test data sets, the same function is used to combine all_test and all_train by column creating the "all_data" variable.After this, grep() is used to extract the names of the data set containing only the info of "mean" and "std". all_data is then subset to extract these columns plus the first three columns.

Finally, the melt function is used to melt the data by id, after which dcast is used to tidy up the data.

The result is stored in "tidy_data.txt"
