# Lab 0: Open a Google Cloud Shell and Enable APIs

If you do not have an existing Google Cloud account, you can create a free trial account with $300 credit. Detail is [here]( https://cloud.google.com/free/docs/free-cloud-features#free-trial). Start Free [here](https://console.cloud.google.com/freetrial?facet_utm_source=google&facet_utm_campaign=%28not%2520set%29&facet_utm_medium=%28not%2520set%29&facet_url=https%3A%2F%2Fcloud.google.com%2Ffree&facet_id_list=%5B39300012%2C+39300021%2C+39300118%2C+39300195%2C+39300241%2C+39300318%2C+39300320%2C+39300327%2C+39300346%2C+39300354%2C+39300364%2C+39300374%2C+39300409%2C+39300422%2C+39300437%2C+39300471%2C+39300488%5D&_ga=2.122473995.1400602851.1690300077-1885747788.1690300077&_gac=1.213659168.1690300094.EAIaIQobChMIpqGTu5qqgAMVQiytBh1qLQFoEAAYASAAEgJHJfD_BwE)!
   
**It is recommend to create a new Google Cloud project for this workshop as it is easier to clean up upon completion.** 
    
#### Open a Cloud Shell
Once you successfully log into your Google Cloud account, you can open a Cloud Shell to begin your lab.
          
[![Cloud Shell](./img/GCP_Cloud_Shell.png)](https://shell.cloud.google.com/)
![Google Cloud Shell](./img/GCP_Cloud_Shell_Screen.png)
      
Run the following commands to enable service APIs required for this workshop
```bash
gcloud services enable sourcerepo.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable anthos.googleapis.com
gcloud services enable meshca.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable cloudbuild.googleapis.com
PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} --format='get(projectNumber)')"
gcloud projects add-iam-policy-binding ${PROJECT_NUMBER} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/container.developer
```
