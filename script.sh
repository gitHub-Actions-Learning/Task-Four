#!/bin/bash
set -e

ChnagedDirs=$(git diff --name-only HEAD | awk -F'/' '{print $1"/"$2"/"$3;}')

module=$(git diff --name-only HEAD | awk -F'/' '{print $2;}') #get module name --> VPC
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
# git commit -m "Updateing VPC and S3"
git tag -a $newTagName -m "uploading $newTagName" #vpc-v6 #tag types ==> light / annotate ==> full info
git push origin $newTagName
# git push origin test



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