The main folder of the R script (run_analysis.R) to be run is E:\DataScience, and downloaded zip file (getdata_projectfiles_UCI HAR Dataset.zip)
needs to be unzipped into the sub-folder called E:\DataScience\UCI_HAR

Introduction of other Files in the Repository
run_analysis.R - This is the R script file via which you can get the result data set called tidydata.text
tidydata.txt - This is the final tidy dataset after you have run the script mentioned above.
codebook.txt - This is the introduction about variables for each of the columns in tidydata.text

Introduction of mechanism about run_analysis.R
1 Read Training dataset into the data frame called traindata (using method called read.table)
2 Read Test dataset into the data frame called testdata (using read.table too)
3 Read Subject, Activity and Features dataset
3 Update variable labels of both of traindata & testdata using data frames mentioned above
4 Merge traindata with testdata into one data frame called grossdata
5 Extract sub-dataset from grossdata (only measurable variables containing mean & std key words)
6 Join grossdata with activity labels dataset in order to acquire the activity labels
7 Create the second dataset called tidydata from grossdata (excluding the column of activitylabel)
8 Merge and cast the original tidydata so as to get average values of each of measurable variables by groups of activity and subject
9 Output the final dataset into the text file called tidydata.txt (without column and row names)

