package e2e

import (
	"context"
	"errors"

	commonv1 "github.com/douyu/jupiter-layout/gen/api/go/common/v1"
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	mocks "github.com/douyu/jupiter-layout/gen/mocks/grpc"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	"github.com/stretchr/testify/mock"
)

var _ = Describe("exampleService", func() {

	Context("SayHello", func() {
		mockExampleGrpc := &mocks.ExampleInterface{}
		mockExampleGrpc.On("SayHello", mock.Anything).Return(nil)

		exampleService := CreateExampleService()
		exampleService.ExampleGrpc = mockExampleGrpc

		It("normal case", func() {
			Expect(exampleService).ShouldNot(BeNil())

			res, err := exampleService.SayHello(context.Background(), &helloworldv1.SayHelloRequest{
				Name: "bob",
			})
			Expect(err).Should(BeNil())

			Expect(res).Should(Equal(&helloworldv1.SayHelloResponse{
				Data: &commonv1.CommonData{
					Message: "hello world",
				},
			}))
		})

		It("error case", func() {
			mockExampleGrpc := &mocks.ExampleInterface{}
			mockExampleGrpc.On("SayHello", mock.Anything).Return(errors.New("Who are you?"))

			exampleService := CreateExampleService()
			exampleService.ExampleGrpc = mockExampleGrpc

			Expect(exampleService).ShouldNot(BeNil())

			_, err := exampleService.SayHello(context.Background(), &helloworldv1.SayHelloRequest{
				Name: "bob",
			})
			Expect(err).Should(Equal(errors.New("Who are you?")))
		})
	})
})
