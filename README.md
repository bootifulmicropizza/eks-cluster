# Bootiful Micro Pizza AWS EKS cluster

This module contains the neccesary IAC files to create a CodePipeline that creates, via CloudFormation, an EKS cluster.

## Setup

The `create_pipeline.sh` can be used to create the CodePipeline.

The `update_pipeline.sh` can be used to update the existing CodePipeline.

## Client setup

Once the EKS cluster has been created via the CodePipeline, the local client can be configured as follows.

### Update the local kubeconfig

In order to access the EKS cluster, the user will need to be allowed to assume the role created to allow EKS to be administered. In this case it is the `bootifulmicropizza-eks-cluster-admin-role` role. The trust relationship policy document should be updated to include the ARN of the required user to allow that user to assume the role. (At this time IAM groups are not supported and would require a workaround. An alternative to this is to individually add all the users to the aws-auth config map.)

```
      "Principal": {
        "AWS": [
          "arn:aws:iam::{AWS_ACCOUNT_ID}:user/my_user_name"
        ],
```

Once the policy document has been updated, the Kubeconfig can be updated to assume the role:

`aws eks update-kubeconfig --name bootifulmicropizza-eks-cluster --region eu-west-1 --role-arn arn:aws:iam::{AWS_ACCOUNT_ID}:role/bootifulmicropizza-eks-cluster-admin-role`

## Access the Kubernetes dashboard

To use the dashboard, the token is required which can be retrieved using the following command:

`kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')`

The local proxy to serve the dashboard through can then be started:

`kubectl proxy`

Open the browser at http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/ and enter the token when prompted.
