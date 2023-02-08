#!/bin/bash
# run.sh为应用快捷启动脚本，在应用根目录下执行./build/run.sh即可编译并启动应用。

# 使用方法:
# ./build/run.sh
# ./build/run.sh config/config-local.toml
# ./build/run.sh config/config-local.toml 127.0.0.1
# ./build/run.sh config/config-local.toml 127.0.0.1 1234567890
# ./build/run.sh config/config-local.toml 127.0.0.1 99999 userFlags
basePath=$(dirname $(dirname $(readlink -f $0)))
pwd=$(pwd)
pkgPath=${pwd//$GOPATH\/src\//}
appName=$(basename "$PWD")
# 获取启动配置文件，若未传递$1参数，则使用config/exampleserver/config-local.toml。
configFile=$1
echo "config   : $configFile"
if [ "$configFile" == "" ]; then
	configFile=config/exampleserver/config-local.toml
fi

# 获取启动host，若未传递$2参数，则使用0.0.0.0。
host=$2
echo "host     : $host"
if [ "$host" == "" ]; then
	host="0.0.0.0"
fi

# 获取应用id，若未传递$3参数，则使用1234567890。
appID=$3
echo "appID     : $appID"
if [ "$appID" == "" ]; then
	appID="1234567890"
fi

# 获取剩余用户自定义flags。
userFlags="${@:4:$#}"
echo "userFlags: $userFlags"

echo -e "\n当前执行指令:\nmake build -C build BINS=\"$pkgPath/cmd/exampleserver:$appName\" APP_NAME=\"$appName\" APP_ID=$appID && ./bin/$appName -config=$configFile --host=$host $userFlags\n\n\n"
make build -C build BINS="$pkgPath/cmd/exampleserver:$appName" APP_NAME="$appName" APP_ID=$appID && ./bin/$appName -config=$configFile --host=$host $userFlags
