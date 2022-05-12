package e2e

import (
	mocks "github.com/douyu/jupiter-layout/mocks/grpc"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("exampleService", func() {

	mockExampleGrpc := &mocks.ExampleInterface{}

	exampleService := CreateExampleService()
	exampleService.ExampleGrpc = mockExampleGrpc

	Context("List", func() {
		It("normal case", func() {
			Expect(exampleService).ShouldNot(BeNil())
		})
	})
})
