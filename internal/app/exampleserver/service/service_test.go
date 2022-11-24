package service

import (
	"context"
	"reflect"
	"testing"

	"github.com/BurntSushi/toml"
	commonv1 "github.com/douyu/jupiter-layout/gen/api/go/common/v1"
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	"github.com/douyu/jupiter-layout/internal/pkg/mysql"
	"github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/douyu/jupiter-layout/internal/pkg/resty"
	"github.com/douyu/jupiter-layout/internal/pkg/rocketmq"
	"github.com/douyu/jupiter/pkg/conf"
	"github.com/douyu/jupiter/pkg/conf/datasource/file"
)

func init() {
	conf.LoadFromDataSource(file.NewDataSource("../../../../config/exampleserver/local-live.toml", false), toml.Unmarshal)
}

func TestHelloWorld_SayHello(t *testing.T) {
	type fields struct {
		Options Options
	}
	type args struct {
		ctx context.Context
		req *helloworldv1.SayHelloRequest
	}
	tests := []struct {
		name    string
		fields  fields
		args    args
		want    *commonv1.CommonData
		wantErr bool
	}{
		{
			name: "test",
			fields: fields{
				Options: Options{
					ExampleGrpc:     grpc.NewExample(),
					ExampleMysql:    mysql.NewExample(),
					ExampleRedis:    redis.NewExample(),
					ExampleResty:    resty.NewExample(),
					ExampleRocketMQ: rocketmq.NewInstance(),
				},
			},
			args: args{
				ctx: context.Background(),
				req: &helloworldv1.SayHelloRequest{
					Name: "test",
				},
			},
			want: &commonv1.CommonData{
				Message: "hello test",
			},
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			s := &HelloWorld{
				Options: tt.fields.Options,
			}
			got, err := s.SayHello(tt.args.ctx, tt.args.req)
			if (err != nil) != tt.wantErr {
				t.Errorf("HelloWorld.SayHello() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("HelloWorld.SayHello() = %v, want %v", got, tt.want)
			}
		})
	}
}
