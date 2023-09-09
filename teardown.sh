#!/bin/bash

export PROJECT_ID=$(gcloud info --format='value(config.project)')
export CLUSTER_LOCATION=us-central1
export CLUSTER_NAME="redis-gke-cluster-$CLUSTER_LOCATION"
export ZONE=us-central1-a
export POSTGRESQL_INSTANCE=redis-postgresql-instance
export REDIS_CLOUD_BUILD_TRIGGER="redis-cb-trigger"

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
