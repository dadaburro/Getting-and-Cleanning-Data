# Getting-and-Cleanning-Data

This repository contains the course project of the Getting and Cleaning Data course from coursera.

The purpose of the project, called run_analysis, is to prepare a tidy data set from the train and test sets taken from the UCI Human Activity Recognition data sets.

All variables are named to reflect the target measurements from the datasets.

It starts with the file download and ends with the creation of a new tidy file called tidy_data.txt

The code first assings variable name to feaures an labels and then naming the the variables of the test and train sets.

It then adds the variable columns to the test and train sets, then combining the test and train sets into one single data set.
This new data set is subset to extract only the MEAN and STD variables and it's corresponding observations.

A new file is created with the tidy data that is ready for posterior analysis.








