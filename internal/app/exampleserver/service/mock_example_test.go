package service

import (
	"context"

	commonv1 "github.com/douyu/jupiter-layout/gen/api/go/common/v1"
	helloworldv1 "github.com/douyu/jupiter-layout/gen/api/go/helloworld/v1"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("exampleService", func() {

	Context("SayHello", func() {
		exampleService := createMockHelloWorldService()

		It("normal case", func() {
			Expect(exampleService).ShouldNot(BeNil())

			res, err := exampleService.SayHello(context.Background(), &helloworldv1.SayHelloRequest{
				Name: "bob",
			})
			Expect(err).Should(BeNil())

			Expect(res).Should(Equal(&commonv1.CommonData{
				Message: "hello bob",
			}))
		})

	})
})
