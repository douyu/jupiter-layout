// Code generated by mockery v2.19.0. DO NOT EDIT.

package grpc

import (
	context "context"

	helloworldv1 "github.com/douyu/jupiter-layout/api/helloworld/v1"
	mock "github.com/stretchr/testify/mock"
)

// MockExampleInterface is an autogenerated mock type for the ExampleInterface type
type MockExampleInterface struct {
	mock.Mock
}

// SayHello provides a mock function with given fields: ctx, req
func (_m *MockExampleInterface) SayHello(ctx context.Context, req *helloworldv1.SayHelloRequest) (*helloworldv1.SayHelloResponse, error) {
	ret := _m.Called(ctx, req)

	var r0 *helloworldv1.SayHelloResponse
	if rf, ok := ret.Get(0).(func(context.Context, *helloworldv1.SayHelloRequest) *helloworldv1.SayHelloResponse); ok {
		r0 = rf(ctx, req)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(*helloworldv1.SayHelloResponse)
		}
	}

	var r1 error
	if rf, ok := ret.Get(1).(func(context.Context, *helloworldv1.SayHelloRequest) error); ok {
		r1 = rf(ctx, req)
	} else {
		r1 = ret.Error(1)
	}

	return r0, r1
}

type mockConstructorTestingTNewMockExampleInterface interface {
	mock.TestingT
	Cleanup(func())
}

// NewMockExampleInterface creates a new instance of MockExampleInterface. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
func NewMockExampleInterface(t mockConstructorTestingTNewMockExampleInterface) *MockExampleInterface {
	mock := &MockExampleInterface{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}
