#!/bin/bash

export PROJECT_ID=$(gcloud info --format='value(config.project)')
export CLUSTER_LOCATION=us-central1
export CLUSTER_NAME="redis-gke-cluster-$CLUSTER_LOCATION"
export ZONE=us-central1-a
export POSTGRESQL_INSTANCE=redis-postgresql-instance
export REDIS_CLOUD_BUILD_TRIGGER="redis-cb-trigger"

# remove container images
CONTAINER_REGISTRY=gcr.io/$PROJECT_ID
gcloud container images list --repository=$CONTAINER_REGISTRY --format='get(name)' | grep "redis-ms-cqrs" > images_list1.txt
while read -r image; do
    echo "Y" | gcloud container images delete "$image" --force-delete-tags --quiet
done < images_list1.txt

CONTAINER_REGISTRY=gcr.io/$PROJECT_ID
gcloud container images list --repository=$CONTAINER_REGISTRY --format='get(name)' | grep "redis-ms-cqrs" > images_list2.txt
while read -r image; do
    tag=`gcloud container images list-tags "$image" | grep DIGEST | awk '{ print $2 }'`
    echo "Y" | gcloud container images delete "$image"@sha256:"$tag" --force-delete-tags --quiet
done < images_list2.txt

# remove Cloud Build trigger
gcloud alpha builds triggers delete $REDIS_CLOUD_BUILD_TRIGGER --region=$CLUSTER_LOCATION

# remove CLoudSQL PostgreSQL instance
echo "Y" | gcloud sql instances delete $POSTGRESQL_INSTANCE

# unregsiter Anthos fleet membership
gcloud container fleet memberships unregister $CLUSTER_NAME-membership \
  --gke-cluster=${CLUSTER_LOCATION}/${CLUSTER_NAME}

# remove GKE cluster
echo "Y" | gcloud container clusters delete $CLUSTER_NAME --region=$CLUSTER_LOCATION

# remove two public reserved static IP addresses
echo "Y" | gcloud compute addresses delete redis-api-gateway-ip --region us-central1
echo "Y" | gcloud compute addresses delete redis-client-host-ip --region us-central1

# remove the GCP project
# gcloud projects delete $PROJECT_ID
