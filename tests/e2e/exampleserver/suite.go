package exampleserver

import (
	"net/http"

	helloworldv1 "github.com/douyu/jupiter-layout/api/helloworld/v1"
	"github.com/douyu/jupiter/pkg/client/grpc"
	"github.com/douyu/jupiter/pkg/client/resty"
	"github.com/douyu/jupiter/pkg/core/tests"
	"github.com/onsi/ginkgo/v2"
)

var _ = ginkgo.Describe("exampleServer", func() {

	ginkgo.DescribeTable("HTTP", func(htc tests.HTTPTestCase) {
		tests.RunHTTPTestCase(htc)
	},
		ginkgo.Entry("SayHello", tests.HTTPTestCase{
			Conf: &resty.Config{
				Addr: "http://localhost:9527",
			},
			Method:       http.MethodPost,
			Path:         "/v1/helloworld.Greeter/SayHello",
			Header:       map[string]string{"Content-Type": "application/x-www-form-urlencoded"},
			Body:         "name=bob",
			ExpectBody:   `{"error":0,"msg":"","data":{"name":"hello bob","ageNumber":0,"sex":0,"metadata":null}}`,
			ExpectStatus: http.StatusOK,
		}),
	)

	ginkgo.DescribeTable("GRPC", func(gtc tests.GRPCTestCase) {
		tests.RunGRPCTestCase(gtc)
	},
		ginkgo.Entry("SayHello", tests.GRPCTestCase{
			Conf: &grpc.Config{
				Addr: "localhost:9528",
			},
			Method: "/helloworld.v1.GreeterService/SayHello",
			Args: &helloworldv1.SayHelloRequest{
				Name: "bob",
			},
			ExpectReply: &helloworldv1.SayHelloResponse{
				Data: &helloworldv1.SayHelloResponse_Data{
					Name: "hello bob",
				},
			},
		}),
		ginkgo.Entry("SayHello invalid name", tests.GRPCTestCase{
			Conf: &grpc.Config{
				Addr: "localhost:9528",
			},
			Method: "/helloworld.v1.GreeterService/SayHello",
			Args:   &helloworldv1.SayHelloRequest{},
			ExpectReply: &helloworldv1.SayHelloResponse{
				Error: 3,
				Msg:   "name is empty",
			},
		}),
	)
})
