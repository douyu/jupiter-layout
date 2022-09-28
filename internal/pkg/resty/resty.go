package resty

import (
	"context"

	"github.com/douyu/jupiter/pkg/client/resty"
	"github.com/douyu/jupiter/pkg/xlog"
	"github.com/google/wire"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

var ProviderSet = wire.NewSet(
	NewExample,
)

type Example struct {
	cc *resty.Client
}

type ExampleModel struct {
	gorm.Model
}

func NewExample() ExampleInterface {
	client, err := resty.StdConfig("example").Build()
	if err != nil {
		panic(err)
	}

	return &Example{
		cc: client,
	}
}

func (s *Example) HttpBin(ctx context.Context) (string, error) {
	res, err := s.cc.R().SetContext(ctx).Get("get")
	if err != nil {
		xlog.L(ctx).Error("httpbin failed", zap.Error(err))
		return "", err
	}

	return res.String(), nil
}
