// Code generated by struct2interface; DO NOT EDIT.

package resty

import (
	"context"
)

// ExampleInterface ...
type ExampleInterface interface {
	SayHello(ctx context.Context) (string, error)
}