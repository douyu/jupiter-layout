package e2e

import (
	"testing"

	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
)

func TestMockSuites(t *testing.T) {
	stop := startServer()
	defer stop()

	RegisterFailHandler(Fail)
	RunSpecs(t, "mock test cases")
}
