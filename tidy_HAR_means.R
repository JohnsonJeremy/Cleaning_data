tidy_HAR_means=function(){
     ## Read in HAR tidy dataset
     hartidy<-read.csv(file="tidy_HAR_dataset.csv")
     ## Use aggregate function to determine the mean of each value for each subject
     ##  and activity combination
     means_frame<-aggregate(x=hartidy[4:9], by=list(hartidy$subject, hartidy$activity), 
                            FUN=mean, na.rm=TRUE)
     
     
     ## Create the column labels and sort the results by subject and activity
     colnames(means_frame)<-c("subject", "activity", "accel_mean_x", "accel_mean_y", 
                              "accel_mean_z","accel_stdev_x", "accel_stdev_y", 
                              "accel_stdev_z")
     means_frame<-means_frame[order(means_frame$subject, means_frame$activity),]   
     
     # Write the results to a CSV and return the results to the calling function
     write.csv(means_frame, file="tidy_HAR_means.csv", row.names = FALSE)
     means_frame
}