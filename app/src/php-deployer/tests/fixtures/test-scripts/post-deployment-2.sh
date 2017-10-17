#!/bin/sh

mkdir "{{projectDirectoryPath}}/post-deployment-update-test"
echo "{{project}}-update" > {{projectDirectoryPath}}/post-deployment-update-test/project.txt
mkdir "{{projectDirectoryPath}}/{{environment}}/post-deployment-update-test"
{%for deploymentEnvironment in deploymentEnvironments%}
    touch "{{projectDirectoryPath}}/{{environment}}/{{deploymentEnvironment}}/post-deployment-update-{{deploymentEnvironment}}"
{%endfor%}