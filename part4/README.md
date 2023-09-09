# Part 4: Delete all resources created in this workshop from your Google Cloud project

It is very important we follow these steps to delete cloud resources created in this workshop to avoid unexpected charges from your Google Cloud project.
      
In this lab, you are going to:
* Remove all cloud resources created in this workshop
* Optionally, remove the Google Cloud project created in this workshop    
   
Remove all cloud resources:
```bash
./teardown.sh 
```
   
Delete the Google Cloud Project 
```bash
export PROJECT_ID=$(gcloud info --format='value(config.project)')
gcloud projects delete $PROJECT_ID
```


