Chad Salinas
Data Cleaning Final Project
9/11/2016
codebook.md


CodeBook -Info about variables, including units, in the data set not contained in the tidy data
SubjectID - Identifies 1 of 30 subjects that performed various tests
Activity - Indicates 1 of 6 activites subject was doing when measurements were taken
        1. WALKING
        2. WALKING_UPSTAIRS
        3. WALKING_DOWNSTAIRS
        4. SITTING
        5. STANDING
        6. LAYING

86 performance measurements of 651 measurements contained mean or std measurements.  Those divise into either 'f' or 't' - prefixed
variable names indication tests from the time or frequency domain.

Choices - Info about the summary choices I made
I chose to select and leave intact those 86 measurements that included either mean or std in the descriptor. I think renaming them would 
worsen the already long column names.  Breaking up a variable name into 4 parts:
1. t or f prefix indicating measurement is that of time or frequency
2. Action performed i.e. BodyGyro, BodyAcc(eleration)Jerk
   Acc = Acceleration
   Mag = Magnitude
3. Measurement is either mean or std
4. Measurement can either be for X, Y, or Z axis

For Study Design and Intstruction List to get tidy data, see README.md


