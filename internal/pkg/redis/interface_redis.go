// Code generated by struct2interface; DO NOT EDIT.

package redis

import (
	"context"
)

// ExampleInterface ...
type ExampleInterface interface {
	Info(ctx context.Context) (string, error)
}