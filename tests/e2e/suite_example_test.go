package e2e

import (
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

var _ = Describe("exampleService", func() {

	exampleService := CreateExampleService()

	Context("List", func() {
		It("normal case", func() {
			Expect(exampleService).ShouldNot(BeNil())
		})
	})
})
