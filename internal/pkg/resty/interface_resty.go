// Code generated by struct2interface; DO NOT EDIT.

package resty

import (
	"context"
)

// ExampleInterface ...
type ExampleInterface interface {
	HttpBin(ctx context.Context) (string, error)
}
