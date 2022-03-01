#!/bin/bash
set -e

ChnagedDirs=$(git diff --name-only HEAD | awk -F'/' '{print $1"/"$2"/"$3;}' | uniq) #array of dirs
echo $ChanagedDirs

# for eachDir in $ChanagedDirs
# do
#init 
#plan
#scan
#apply
#publish 
#destroy
# done

# we have two scenarios 
# 1- create pipeline script and call all the scripts in it then call it inside terraform.yml
#  if [[ -f pipeline.sh ]] chmod and run


# 2- add the whole pipeline in terraform.yml in loop

module=$(git diff --name-only HEAD | awk -F'/' '{print $2;}' | uniq) #get module name --> VPC
echo $module
                           #VPC-v* 1 2 3 4 5
latestTag=$(git describe --tags --match "$module-v*" --abbrev=0 `git rev-list --tags --max-count=1`)
echo $latestTag #vpc-v5
# $1 -v $2
latestTagVersion=$(echo $latestTag | awk -F'-v' '{print $2; exit}')
echo $latestTagVersion
((latestTagVersion=latestTagVersion+1)) # 5 -> 6    
echo $latestTagVersion

newTagName=$module-v$latestTagVersion #vpc-v6
echo $newTagName

git add .
git commit -m "Updateing VPC and S3"
git tag -a $newTagName -m "uploading $newTagName" #vpc-v6 #tag types ==> light / annotate ==> full info
git push origin $newTagName
git push origin test

#more than on module vpc/s3 ==> 
# 1- will create 2 tags for each module with new version
# 2- will need to cd for each dir have chnages and run the whole pipeline ==> 
# so need to run all pipelines scripts inn loop accordinng to number of chnaged dirs
# 3- we need to push on a specific branch after push the tagged files


# command:
#     - init
#     - if [[    ]]

# for d in $ChnagedDirs
# do
#   cd module 
#   Run pipline steps
#   init
#   .
#   .
#   .
#   destroy
# done

# terraform init 

# terraform plan -out tf.plan

# if [[ -f tf.plan ]]
# then
#     appliedResult=$(terraform apply -auto-approve tf.plan)
#     if [ ! $appliedResult ]
#     then
#         terraform destroy -auto-approve
#         echo "Destroyed"
#     fi
# fi

# if [[ -f test.txt ]]
# then
#     echo "Founded"
# fi


