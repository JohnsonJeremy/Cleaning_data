har_data_tidy=function(){

     ## Data files must be located in "test" and "train" subdirectories of the working
     #     directory.  Resulting text files will be written to working directory.  
     #     the function will return the result so that the user can immediately view the 
     #     tidy results without having to open the csv file.
   
     activity_list<-c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting",
                     "Standing", "Laying")

     ## Get and process test data     
     ## Go to test data 
     setwd("./test")
     
     # Read subject, label, and results from respective files.
     subject_test<-read.table("subject_test.txt")
     test_labels<-read.table("y_test.txt")
     x_data<-read.table("x_test.txt")
     
     # Convert to data frame and move the subject to the second column and label data
     test_data<-as.data.frame(subject_test)
     test_data[,2]<-test_data[,1]
     test_data[,1]<-c("test_set")
     
     # Place the activities in the data table with labels replacing respective values
     for(i in 1:nrow(test_labels)) {test_data[i,3]<-activity_list[test_labels[i,1]]}
     
     # Append actual test data to data frame and label columns
     test_data[,4:9]<-x_data[,1:6]
     colnames(test_data)<-c("set", "subject", "activity", "accel_mean_x", "accel_mean_y", 
                         "accel_mean_z", "accel_stddev_x", "accel_stddev_y", 
                         "accel_stddev_z")

     ## Get and process training data
     ## See notes in Test section above for description of functions.
     setwd("../train")
     subject_test<-read.table("subject_train.txt")
     test_labels<-read.table("y_train.txt")
     x_data<-read.table("x_train.txt")
     train_data<-as.data.frame(subject_test)
     train_data[,2]<-train_data[,1]
     train_data[,1]<-c("train_set")     
     for(i in 1:nrow(test_labels)) {train_data[i,3]<-activity_list[test_labels[i,1]]}
     train_data[,4:9]<-x_data[,1:6]
     colnames(train_data)<-c("set", "subject", "activity", "accel_mean_x", "accel_mean_y", 
                            "accel_mean_z", "accel_stddev_x", "accel_stddev_y", 
                            "accel_stddev_z")
     
     # Combine the test and training data and sort by subject
     accel_data<-rbind(test_data, train_data)
     accel_data<-accel_data[order(accel_data$subject),]
     
     # Convert the subject into a factor (unnecessary but cleaner)
     accel_data$subject<-as.factor(accel_data$subject)
     
     ## Write the results to a CSV file and return the results to the calling function.
     setwd("..")
     write.csv(accel_data, file="tidy_HAR_dataset.csv", row.names = FALSE)
     
     accel_data
     
}