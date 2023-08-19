#!/bin/bash
IMAGE_TAG="${ECR_URI}:TAG_VALUE"
echo "✅ Building ECS NodeJS API"
docker build -t ${IMAGE_TAG} -f ${CODEBUILD_SRC_DIR}/codebuild/Dockerfile.node ${CODEBUILD_SRC_DIR}/${SRC_NODE}
docker push ${IMAGE_TAG}
sed -i "s|task_definition|${TASK_DEFINITION}|g" ${CODEBUILD_SRC_DIR}/codedeploy/appspec.yml
sed -i "s|lambda_alert_action|${LAMBDA_ALERT_ARN}|g" ${CODEBUILD_SRC_DIR}/codedeploy/appspec.yml
sed -i "s|image_url|${IMAGE_TAG}|g" ${CODEBUILD_SRC_DIR}/codedeploy/taskdef.json
