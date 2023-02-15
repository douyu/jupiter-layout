# build

## Usage example
* We can use this command to quickly build and start jupiter project with specified project parameters
* Use this command in the project root directory

```shell
make build -C build BINS="cmd/exampleserver:jupiter-layout" APP_NAME="jupiter-layout" APP_ID="12345" && ./bin/jupiter-layout -config=config/exampleserver/local-live.toml --host=127.0.0.1
```
**Parameter description**
* APP_NAME: Application name
* APP_ID: Application ID

