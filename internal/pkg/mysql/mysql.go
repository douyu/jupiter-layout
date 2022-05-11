package mysql

import (
	"github.com/douyu/jupiter/pkg/store/gorm"
	"github.com/google/wire"
)

var ProviderSet = wire.NewSet(
	NewExample,
)

type ExampleInterface interface {
}

type Example struct {
	cc *gorm.DB
}

func NewExample() ExampleInterface {
	return &Example{
		cc: gorm.StdConfig("example").Build(),
	}
}
