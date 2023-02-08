#!/bin/bash

versionInfo=($(go version))
ver=${versionInfo[2]}
ver=(${ver//./ })
mainVerison=${ver[0]}
mainVerison=(${mainVerison//go/})
subVersion=${ver[1]}
# echo -e "Go versioninfo is [$(go version)], fullVersion is ${versionInfo[2]}, mainVersion=$mainVerison subVersion=$subVersion\n"
if [[ $mainVerison -ge 1 && $subVersion -ge 13 ]]; then
    # echo -e "Go version is equal or higher than 1.13, ready to use \"-mod -vendor\" command to build project\n"
    echo 1
else
    # echo -e "Go version is lower than 1.13, not use \"-mod -vendor\" command to build project\n"
    echo 0
    # return 1
fi