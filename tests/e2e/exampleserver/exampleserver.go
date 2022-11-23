package exampleserver

import (
	"net/http"

	commonv1 "github.com/douyu/jupiter-layout/gen/api/go/common/v1"
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/douyu/jupiter/pkg/core/tests"
	. "github.com/onsi/ginkgo/v2"
)

var _ = Describe("exampleServer", func() {

	DescribeTable("HTTP", func(htc tests.HTTPTestCase) {
		tests.RunHTTPTestCase(htc)
	},
		Entry("SayHello", tests.HTTPTestCase{
			Host:         "http://localhost:9527",
			Method:       http.MethodGet,
			Path:         "/",
			Query:        "name=bob",
			ExpectBody:   `{"error":0,"msg":"请求正常","data":{"message":"hello bob"}}`,
			ExpectStatus: http.StatusOK,
		}),
	)

	DescribeTable("GRPC", func(gtc tests.GRPCTestCase) {
		tests.RunGRPCTestCase(gtc)
	},
		Entry("SayHello", tests.GRPCTestCase{
			Addr:   "localhost:9528",
			Method: "/helloworld.v1.GreeterService/SayHello",
			Args: &helloworldv1.SayHelloRequest{
				Name: "bob",
			},
			ExpectReply: &helloworldv1.SayHelloResponse{
				Data: &commonv1.CommonData{
					Message: "hello bob",
				},
			},
		}),
	)
})
