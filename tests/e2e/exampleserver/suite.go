package exampleserver

import (
	"net/http"

	helloworldv1 "github.com/douyu/jupiter-layout/api/helloworld/v1"
	"github.com/douyu/jupiter-layout/tests/e2e/framework"
	"github.com/douyu/jupiter/pkg/client/grpc"
	"github.com/douyu/jupiter/pkg/client/resty"
	"github.com/onsi/ginkgo/v2"
)

var _ = ginkgo.Describe("exampleServer", func() {

	ginkgo.DescribeTable("HTTP", func(htc framework.HTTPTestCase) {
		framework.RunHTTPTestCase(htc)
	},
		ginkgo.Entry("SayHello", framework.HTTPTestCase{
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

	ginkgo.DescribeTable("GRPC", func(gtc framework.GRPCTestCase) {
		framework.RunGRPCTestCase(gtc)
	},
		ginkgo.Entry("SayHello", framework.GRPCTestCase{
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
		ginkgo.Entry("SayHello invalid name", framework.GRPCTestCase{
			Conf: &grpc.Config{
				Addr: "localhost:9528",
			},
			Method: "/helloworld.v1.GreeterService/SayHello",
			Args:   &helloworldv1.SayHelloRequest{},
			ExpectReply: &helloworldv1.SayHelloResponse{
				Error: uint32(helloworldv1.Error_ERROR_NAME_EMPTY),
				Msg:   "name is empty",
			},
		}),
	)
})
