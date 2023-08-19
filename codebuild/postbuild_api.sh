#!/bin/bash
DEPLOY_ENABLE=VALUE_DETECT
if [[ "$DEPLOY_ENABLE" == "yes" ]]; then
    curl -X POST -H 'Content-type: application/json' -d '{"text": "'"✅ Done ${COMP} build-stage! Start ${COMP} deploy-stage"'", "username": "'"${NOTI_USER}"'"}' "${NOTI_URL}"
    echo "✅ Updating new artifarct!!!"
    cd ${CODEBUILD_SRC_DIR}/codedeploy/${ENV}/
    zip appspec.zip appspec.yml taskdef.json
    aws s3 rm s3://${S3_ARC}/ChangeParameter/appspec.zip
    aws s3 cp appspec.zip s3://${S3_ARC}/ChangeParameter/appspec.zip
else
    echo "✅ NO NEED TO DEPLOY API CODE!!!"
fi
