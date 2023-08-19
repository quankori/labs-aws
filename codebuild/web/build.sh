#!/bin/bash
echo "✅ Building S3 Source FE..."
docker build -t fe -f ${CODEBUILD_SRC_DIR}/codebuild/${ENV}/Dockerfile.sources3 ${CODEBUILD_SRC_DIR}/${SRC_FE}
docker run -itd --name fe fe
docker cp fe:/app/. ${CODEBUILD_SRC_DIR}/${SRC_FE}
docker stop fe
