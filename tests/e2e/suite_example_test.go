package e2e

import (
	"context"
	"net/http"
	"time"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	"github.com/go-resty/resty/v2"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials/insecure"
)

var _ = Describe("exampleService", func() {

	Context("SayHello", func() {

		It("HTTP", func() {
			res, err := resty.New().R().Get("http://localhost:9527/?name=bob")
			Expect(err).Should(BeNil())
			Expect(res.StatusCode()).Should(Equal(http.StatusOK))
			Expect(string(res.Body())).Should(MatchJSON(`{"error":0,"msg":"请求正常","data":{"message":"hello bob"}}`))
		})

		It("GRPC", func() {
			ctx, cancel := context.WithTimeout(context.Background(), time.Second)
			defer cancel()

			cc, err := grpc.DialContext(ctx, "localhost:9528", grpc.WithBlock(), grpc.WithTransportCredentials(insecure.NewCredentials()))
			Expect(err).Should(BeNil())

			res, err := helloworldv1.NewGreeterServiceClient(cc).SayHello(context.Background(), &helloworldv1.SayHelloRequest{
				Name: "bob",
			})

			Expect(err).Should(BeNil())
			Expect(res.GetError()).Should(BeEquivalentTo(0))
			Expect(res.GetData().GetMessage()).Should(Equal("hello bob"))
		})
	})
})
