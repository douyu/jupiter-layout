package e2e

import (
	"context"

	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	mocks "github.com/douyu/jupiter-layout/gen/mocks/grpc"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("exampleService", func() {

	mockExampleGrpc := &mocks.ExampleInterface{}

	exampleService := CreateExampleService()
	exampleService.ExampleGrpc = mockExampleGrpc

	Context("SayHello", func() {
		It("normal case", func() {
			Expect(exampleService).ShouldNot(BeNil())

			res, err := exampleService.SayHello(context.Background(), &helloworldv1.SayHelloRequest{
				Name: "bob",
			})
			Expect(err).Should(BeNil())

			Expect(res).Should(Equal(&helloworldv1.SayHelloResponse{
				Message: "hello wolrd",
			}))
		})
	})
})
