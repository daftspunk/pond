#!/bin/sh

mkdir "{{projectDirectoryPath}}/post-deployment-test"
echo "{{project}}" > {{projectDirectoryPath}}/post-deployment-test/project.txt
mkdir "{{projectDirectoryPath}}/{{environment}}/post-deployment-test"
{%for deploymentEnvironment in deploymentEnvironments%}
    touch "{{projectDirectoryPath}}/{{environment}}/{{deploymentEnvironment}}/post-deployment-{{deploymentEnvironment}}"
{%endfor%}