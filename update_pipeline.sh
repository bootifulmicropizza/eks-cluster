#!/bin/bash
aws cloudformation update-stack --stack-name 'bootifulmicropizza-eks-cluster-pipeline' \
	--template-body file://iac/cfn_codepipeline.yml --region eu-west-1 \
	--parameters ParameterKey=GitHubToken,ParameterValue=$AWS_GITHUB_TOKEN \
	--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND
