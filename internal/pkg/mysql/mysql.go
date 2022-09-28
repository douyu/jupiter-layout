package mysql

import (
	"context"

	"github.com/douyu/jupiter/pkg/store/gorm"
	"github.com/douyu/jupiter/pkg/xlog"
	"github.com/google/wire"
	"go.uber.org/zap"
)

var ProviderSet = wire.NewSet(
	NewExample,
)

type Example struct {
	cc *gorm.DB
}

type ExampleModel struct {
	gorm.Model
}

func NewExample() ExampleInterface {
	return &Example{
		cc: gorm.StdConfig("example").MustBuild(),
	}
}

func (s *Example) Migrate(ctx context.Context) error {
	err := s.cc.WithContext(ctx).AutoMigrate(&ExampleModel{})
	if err != nil {
		xlog.L(ctx).Error("autoMigrate failed", zap.Error(err))
		return err
	}

	return nil
}
