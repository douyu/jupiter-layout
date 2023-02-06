// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.28.1-devel
// 	protoc        (unknown)
// source: helloworld/v1/error.proto

package helloworldv1

import (
	_ "github.com/douyu/jupiter-layout/api/error/v1"
	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2/options"
	_ "github.com/srikrsna/protoc-gen-gotag/tagger"
	_ "google.golang.org/genproto/googleapis/api/annotations"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// Error codes for the helloworld.v1 package.
type Error int32

const (
	// ERROR_UNSPECIFIED is the invalid code.
	Error_ERROR_UNSPECIFIED Error = 0
	// ERROR_NAME_INVALID is the error code for invalid name.
	Error_ERROR_NAME_INVALID Error = 1000
)

// Enum value maps for Error.
var (
	Error_name = map[int32]string{
		0:    "ERROR_UNSPECIFIED",
		1000: "ERROR_NAME_INVALID",
	}
	Error_value = map[string]int32{
		"ERROR_UNSPECIFIED":  0,
		"ERROR_NAME_INVALID": 1000,
	}
)

func (x Error) Enum() *Error {
	p := new(Error)
	*p = x
	return p
}

func (x Error) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (Error) Descriptor() protoreflect.EnumDescriptor {
	return file_helloworld_v1_error_proto_enumTypes[0].Descriptor()
}

func (Error) Type() protoreflect.EnumType {
	return &file_helloworld_v1_error_proto_enumTypes[0]
}

func (x Error) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use Error.Descriptor instead.
func (Error) EnumDescriptor() ([]byte, []int) {
	return file_helloworld_v1_error_proto_rawDescGZIP(), []int{0}
}

var File_helloworld_v1_error_proto protoreflect.FileDescriptor

var file_helloworld_v1_error_proto_rawDesc = []byte{
	0x0a, 0x19, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x2f, 0x76, 0x31, 0x2f,
	0x65, 0x72, 0x72, 0x6f, 0x72, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x0d, 0x68, 0x65, 0x6c,
	0x6c, 0x6f, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x76, 0x31, 0x1a, 0x14, 0x65, 0x72, 0x72, 0x6f,
	0x72, 0x2f, 0x76, 0x31, 0x2f, 0x65, 0x72, 0x72, 0x6f, 0x72, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x1a, 0x1c, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x61, 0x6e, 0x6e,
	0x6f, 0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x63, 0x2d, 0x67, 0x65, 0x6e, 0x2d, 0x6f, 0x70, 0x65, 0x6e, 0x61,
	0x70, 0x69, 0x76, 0x32, 0x2f, 0x6f, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2f, 0x61, 0x6e, 0x6e,
	0x6f, 0x74, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x13,
	0x74, 0x61, 0x67, 0x67, 0x65, 0x72, 0x2f, 0x74, 0x61, 0x67, 0x67, 0x65, 0x72, 0x2e, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x2a, 0x4c, 0x0a, 0x05, 0x45, 0x72, 0x72, 0x6f, 0x72, 0x12, 0x15, 0x0a, 0x11,
	0x45, 0x52, 0x52, 0x4f, 0x52, 0x5f, 0x55, 0x4e, 0x53, 0x50, 0x45, 0x43, 0x49, 0x46, 0x49, 0x45,
	0x44, 0x10, 0x00, 0x12, 0x2c, 0x0a, 0x12, 0x45, 0x52, 0x52, 0x4f, 0x52, 0x5f, 0x4e, 0x41, 0x4d,
	0x45, 0x5f, 0x49, 0x4e, 0x56, 0x41, 0x4c, 0x49, 0x44, 0x10, 0xe8, 0x07, 0x1a, 0x13, 0xba, 0xd3,
	0x04, 0x0f, 0x6e, 0x61, 0x6d, 0x65, 0x20, 0x69, 0x73, 0x20, 0x69, 0x6e, 0x76, 0x61, 0x6c, 0x69,
	0x64, 0x42, 0x6e, 0x0a, 0x17, 0x63, 0x6f, 0x6d, 0x2e, 0x64, 0x6f, 0x75, 0x79, 0x75, 0x2e, 0x68,
	0x65, 0x6c, 0x6c, 0x6f, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x2e, 0x76, 0x31, 0x42, 0x11, 0x48, 0x65,
	0x6c, 0x6c, 0x6f, 0x57, 0x6f, 0x72, 0x6c, 0x64, 0x50, 0x72, 0x6f, 0x74, 0x6f, 0x56, 0x31, 0x50,
	0x01, 0x5a, 0x3e, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x64, 0x6f,
	0x75, 0x79, 0x75, 0x2f, 0x6a, 0x75, 0x70, 0x69, 0x74, 0x65, 0x72, 0x2d, 0x6c, 0x61, 0x79, 0x6f,
	0x75, 0x74, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x77, 0x6f, 0x72, 0x6c,
	0x64, 0x2f, 0x76, 0x31, 0x3b, 0x68, 0x65, 0x6c, 0x6c, 0x6f, 0x77, 0x6f, 0x72, 0x6c, 0x64, 0x76,
	0x31, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_helloworld_v1_error_proto_rawDescOnce sync.Once
	file_helloworld_v1_error_proto_rawDescData = file_helloworld_v1_error_proto_rawDesc
)

func file_helloworld_v1_error_proto_rawDescGZIP() []byte {
	file_helloworld_v1_error_proto_rawDescOnce.Do(func() {
		file_helloworld_v1_error_proto_rawDescData = protoimpl.X.CompressGZIP(file_helloworld_v1_error_proto_rawDescData)
	})
	return file_helloworld_v1_error_proto_rawDescData
}

var file_helloworld_v1_error_proto_enumTypes = make([]protoimpl.EnumInfo, 1)
var file_helloworld_v1_error_proto_goTypes = []interface{}{
	(Error)(0), // 0: helloworld.v1.Error
}
var file_helloworld_v1_error_proto_depIdxs = []int32{
	0, // [0:0] is the sub-list for method output_type
	0, // [0:0] is the sub-list for method input_type
	0, // [0:0] is the sub-list for extension type_name
	0, // [0:0] is the sub-list for extension extendee
	0, // [0:0] is the sub-list for field type_name
}

func init() { file_helloworld_v1_error_proto_init() }
func file_helloworld_v1_error_proto_init() {
	if File_helloworld_v1_error_proto != nil {
		return
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_helloworld_v1_error_proto_rawDesc,
			NumEnums:      1,
			NumMessages:   0,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_helloworld_v1_error_proto_goTypes,
		DependencyIndexes: file_helloworld_v1_error_proto_depIdxs,
		EnumInfos:         file_helloworld_v1_error_proto_enumTypes,
	}.Build()
	File_helloworld_v1_error_proto = out.File
	file_helloworld_v1_error_proto_rawDesc = nil
	file_helloworld_v1_error_proto_goTypes = nil
	file_helloworld_v1_error_proto_depIdxs = nil
}
