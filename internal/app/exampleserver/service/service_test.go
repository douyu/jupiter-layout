package service

import (
	"context"
	"reflect"
	"testing"

	"github.com/BurntSushi/toml"
	"github.com/apache/rocketmq-client-go/v2/primitive"
	"github.com/douyu/jupiter-layout/internal/pkg/grpc"
	"github.com/douyu/jupiter-layout/internal/pkg/mysql"
	"github.com/douyu/jupiter-layout/internal/pkg/redis"
	"github.com/douyu/jupiter-layout/internal/pkg/resty"
	"github.com/douyu/jupiter-layout/internal/pkg/rocketmq"
	"github.com/douyu/jupiter/pkg/conf"
	"github.com/douyu/jupiter/pkg/conf/datasource/file"
	"github.com/douyu/jupiter/pkg/util/xerror"
	helloworldv1 "github.com/douyu/proto/gen/go/api/helloworld/v1"
	"github.com/stretchr/testify/mock"
)

func init() {
	conf.LoadFromDataSource(file.NewDataSource("../../../../config/exampleserver/local-live.toml", false), toml.Unmarshal)
}

func case1(t *testing.T) Options {
	mockExampleGrpc := grpc.NewMockExampleInterface(t)
	mockExampleGrpc.On("SayHello", mock.Anything, mock.Anything).Return(&helloworldv1.SayHelloResponse{}, nil)

	mockExampleMysql := mysql.NewMockExampleInterface(t)
	mockExampleMysql.On("Migrate", mock.Anything).Return(nil)

	mockExampleRedis := redis.NewMockExampleInterface(t)
	mockExampleRedis.On("Info", mock.Anything).Return("info", nil)

	mockExampleResty := resty.NewMockExampleInterface(t)
	mockExampleResty.On("SayHello", mock.Anything).Return("hello reply", nil)

	mockExampleRocketmq := rocketmq.NewMockExampleInterface(t)
	mockExampleRocketmq.On("PushExampleMessage", mock.Anything, mock.Anything).Return(nil)

	return Options{
		ExampleGrpc:     mockExampleGrpc,
		ExampleMysql:    mockExampleMysql,
		ExampleRedis:    mockExampleRedis,
		ExampleResty:    mockExampleResty,
		ExampleRocketMQ: mockExampleRocketmq,
	}
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
		want    *helloworldv1.SayHelloResponse
		wantErr bool
	}{
		{
			name: "case 1: normal",
			fields: fields{
				Options: case1(t),
			},
			args: args{
				ctx: context.Background(),
				req: &helloworldv1.SayHelloRequest{
					Name: "bob",
				},
			},
			want: &helloworldv1.SayHelloResponse{
				Data: &helloworldv1.SayHelloResponse_Data{
					Name: "hello bob",
				},
			},
			wantErr: false,
		},
		{
			name: "case 2: empty name",
			fields: fields{
				Options: Options{},
			},
			args: args{
				ctx: context.Background(),
				req: &helloworldv1.SayHelloRequest{
					Name: "",
				},
			},
			want: &helloworldv1.SayHelloResponse{
				Error: 1000,
				Msg:   "name is empty",
			},
			wantErr: false,
		},
		{
			name: "case 3: validate name",
			fields: fields{
				Options: Options{},
			},
			args: args{
				ctx: context.Background(),
				req: &helloworldv1.SayHelloRequest{
					Name: "invalid name",
				},
			},
			want: &helloworldv1.SayHelloResponse{
				Error: uint32(xerror.InvalidArgument.GetEcode()),
				Msg:   "invalid SayHelloRequest.Name: value must equal bob",
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

func TestHelloWorld_ProcessConsumer(t *testing.T) {
	type fields struct {
		Options Options
	}
	type args struct {
		ctx context.Context
		msg *primitive.MessageExt
	}
	tests := []struct {
		name    string
		fields  fields
		args    args
		wantErr bool
	}{
		{
			name: "test",
			fields: fields{
				Options: Options{},
			},
			args: args{
				ctx: context.Background(),
				msg: &primitive.MessageExt{},
			},
			wantErr: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			s := &HelloWorld{
				Options: tt.fields.Options,
			}
			if err := s.ProcessConsumer(tt.args.ctx, tt.args.msg); (err != nil) != tt.wantErr {
				t.Errorf("HelloWorld.ProcessConsumer() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}
