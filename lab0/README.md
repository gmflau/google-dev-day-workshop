# Lab 0: Open a Google Cloud Shell and Enable APIs

[![Cloud Shell](./img/GCP_Cloud_Shell.png)](https://shell.cloud.google.com/)
![Google Cloud Shell](./img/GCP_Cloud_Shell_Screen.png)
    
Run the following commands to enable service APIs required for this workshop"
```bash
gcloud services enable sourcerepo.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable anthos.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable cloudbuild.googleapis.com
PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} --format='get(projectNumber)')"
gcloud projects add-iam-policy-binding ${PROJECT_NUMBER} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/container.developer
```
