#!/bin/bash
set -e

ChnagedDirs=$(git diff --name-only HEAD | awk -F'/' '{print $1"/"$2"/"$3;}' | uniq)

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

module=$(git diff --name-only HEAD | awk -F'/' '{print $2;}' | uniq) #get module name --> VPC
echo $module

for m in $module
do                            #VPC-v* 1 2 3 4 5
    latestTag=$(git describe --tags --match "$m-v*" --abbrev=0 `git rev-list --tags --max-count=1`)
    echo $latestTag #vpc-v5
    # $1 -v $2
    latestTagVersion=$(echo $latestTag | awk -F'-v' '{print $2; exit}')
    echo $latestTagVersion
    ((latestTagVersion=latestTagVersion+1)) # 5 -> 6    
    echo $latestTagVersion

    newTagName=$m-v$latestTagVersion #vpc-v6
    echo $newTagName

    git add .
    git commit -m "Updateing VPC and S3"
    git tag -a $newTagName -m "uploading $newTagName" #vpc-v6 #tag types ==> light / annotate ==> full info
    git push origin $newTagName

done



# command:
#     - init
#     - if [[    ]]