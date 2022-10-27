package e2e

import (
	"testing"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

func TestMockSuites(t *testing.T) {
	startServer()

	RegisterFailHandler(Fail)
	RunSpecs(t, "mock test cases")
}
