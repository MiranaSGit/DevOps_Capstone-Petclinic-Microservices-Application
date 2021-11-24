Create a Jenkins job with the name of `test-msp-17-scripts` to test the scripts:   
    * Select `Freestyle project` and click `OK`
    * Select github project and write the url to your repository's page into `Project url` (https://github.com/[your-github-account]/petclinic-microservices)
    * Under the `Source Code Management` select `Git` 
    * Write the url of your repository into the `Repository URL` (https://github.com/[your-github-account]/petclinic-microservices.git)
    * Add `*/feature/msp-17` branch to `Branches to build`
    * Click `Add build step` under `Build` and select `Execute Shell`
    * Write below script into the `Command`
    ```bash
    PATH="$PATH:/usr/local/bin"
    APP_REPO_NAME="mirana2-repo/petclinic-app-dev" # Write your own repo name. Check app repo name not exist in ECR!
    AWS_REGION="us-east-1" #Update this line if you work on another region
    ECR_REGISTRY="360800251837.dkr.ecr.us-east-1.amazonaws.com" # Replace this line with your ECR name
    aws ecr create-repository \
        --repository-name ${APP_REPO_NAME} \
        --image-scanning-configuration scanOnPush=false \
        --image-tag-mutability MUTABLE \
        --region ${AWS_REGION}
    . ./jenkins/package-with-maven-container.sh
    . ./jenkins/prepare-tags-ecr-for-dev-docker-images.sh
    . ./jenkins/build-dev-docker-images-for-ecr.sh
    . ./jenkins/push-dev-docker-images-to-ecr.sh
    ```
    * Click `Save`
    * Click `Build now` to manually start the job.