# Lab 1: Create a Cloud Source repo for the workshop sample app
    
Set the following values:
```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

For example,
git config --global user.email "gmflau007@gmail.com"
git config --global user.name "Gilbert"
```
        
Create a new Cloud Source repo:
```bash
export PROJECT_ID=$(gcloud info --format='value(config.project)')
export REDIS_REPO="redis-repo-$(date +'%Y%m%d%H%M%S')"
gcloud source repos create $REDIS_REPO
git clone https://source.developers.google.com/p/$PROJECT_ID/r/$REDIS_REPO
```
Deposit workshop sample app into the repo:
```bash
cd $REDIS_REPO
gsutil cp gs://redis-dev-days-workshop/google-dev-day-workshop-main.zip .
unzip google-dev-day-workshop-main.zip
mv google-dev-day-workshop-main/{*,.[^.]*,..?*} .
rm -fr google-dev-day-workshop-main
rm google-dev-day-workshop-main.zip
git add .
git commit -m "Initial commit"
git push -u origin master
```
You can confirm the repo has been successfully created in Google Cloud Console:
![Cloud Sources Repo](./img/Cloud_Sources_Repo.png)
     
[<< Previous Lab (0) <<](../lab0/README.md)     |      [>> Next Lab (2) >>](../lab2/README.md)
