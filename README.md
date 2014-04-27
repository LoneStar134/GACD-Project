GACD-Project
============

Coursera:  Getting and Creating Data Project Repo


The run_analysis.R script creates a tidy data set from raw data sets of motion data
captured by the gyroscope and accelerometers on a Samsung mobile phone.

The following summarizes the steps taken to tidy up the raw data:

1.  Set the working directory where Samsung data can be found;
2.  Load the reshape2 library to allow use of melt & dcast functions for tidying up the
	data set;
3.  Set the numeric precision to 15 digits to assure no precision is lost when 
	importing Samsung raw data;
4.  Load the features.txt and activity_labels.txt files to get the column headers for
	the raw data that is to be imported;
5.  Load all TEST data sets.  Provide appropriate column names using data loaded from 
	features.txt;
6.  Combine all test data sets into a single data set (wide with all columns represented);
7.  Free memory for all the individual test sets loaded;
8.  Load all TRAINING data sets.  Provide appropriate column names using data loaded from 
	features.txt;
9.  Combine all TRAINING data sets into a single data set (wide with all columns represented);
10. Free memory for all the individual training sets loaded;
11. Merge in Activity labels associated with the appropriate activity labels loaded
	in step 4;
12. Combine test and training into one data set (bigset).  bigset will remain in memory
	but will not be output to a file;
13. Use reshape2/melt to reorganize the data by Subject ID, Activity Name, and a restricted
	list of variables that only include the mean measurements;
14. Use reshape2/dcast to reorganize the data to create the target tidy data set 
	tidyset-final.csv in CSV format.  The columns will include Subject ID, Activity Name,
	and all the other mean measurements associated with that Subject and Activity;
15.  Free memory for any intermediate variables to used during the process with 
	exception of a few tables that remain in memory for convenience should detail data
	be required.
