# Getting and Cleaning Data Course Project

This is the course project for Coursera's "Getting and Cleaning Data" course.

### Files

* Dataset used in this project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* `run_analysis.R` is the R script that:
	* Download the dataset (if not yet downloaded) and unzip it.
	* Load the test and training data from the dataset, and subset the columns with mean and standart deviation values
	* Loads the activity and subject data, and merges those columns with the dataset
	* Merges the datasets
	* Rename the labels from the merged dataset so it is more descriptive
	* Creates a tidy dataset that consists of the average (mean) value of each variable (for each subject and activity).

* `codeBook.md` describing the data

* `tidyData.txt` with the result from the R script

