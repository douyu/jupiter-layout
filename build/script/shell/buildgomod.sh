#!/bin/bash

set -e
basePath=$(dirname $(dirname $(dirname $(dirname $(readlink -f $0)))))

echo -e "\nBuilding binaries in ${basePath}"
declare -a bins=${@:2}

# 开启gomod
export GO111MODULE=on

cd ${basePath}
rm -rf ./bin/*
for task in ${bins[@]}
do
    echo building ${task}...
    read pkgPath  <<< $(echo ${task} | awk -F ":" '{ print $1 }')
    read binName  <<< $(echo ${task} | awk -F ":" '{  print $2 }')
    echo pkgPath:${pkgPath}, binName:${binName}
    echo ldflags:$1
    go build -mod=vendor -ldflags "$1" -o ./bin/$(echo $(echo ${binName} -v | awk -F/ '{print $NF}') ${pkgPath})
    echo -e "\n"
done

if [ -d "${basePath}/cmd/task" ];then
    for file in ${basePath}/cmd/*; do
        echo building ${file}...
        echo pkgPath:${file}, binName:$(basename  $file)
        cd ${file}
        go build -mod=vendor -ldflags "$1" -o ${basePath}/bin/job/$(echo $(basename  $file))
        echo -e "\n"
    done
fi
