// Code generated by mockery v2.13.1. DO NOT EDIT.

package mocks

import (
	context "context"

	mock "github.com/stretchr/testify/mock"
)

// ExampleInterface is an autogenerated mock type for the ExampleInterface type
type ExampleInterface struct {
	mock.Mock
}

// Migrate provides a mock function with given fields: ctx
func (_m *ExampleInterface) Migrate(ctx context.Context) error {
	ret := _m.Called(ctx)

	var r0 error
	if rf, ok := ret.Get(0).(func(context.Context) error); ok {
		r0 = rf(ctx)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

type mockConstructorTestingTNewExampleInterface interface {
	mock.TestingT
	Cleanup(func())
}

// NewExampleInterface creates a new instance of ExampleInterface. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
func NewExampleInterface(t mockConstructorTestingTNewExampleInterface) *ExampleInterface {
	mock := &ExampleInterface{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}
