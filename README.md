# protoc-gen-go-errors

自定义 go-kratos/kratos 错误；

当前版本: v2.7.3 [version](./version.go)

* kratos [kratos](https://github.com/go-kratos/kratos)
* protoc-gen-go-errors [protoc-gen-go-errors](https://github.com/go-kratos/kratos/blob/main/cmd/protoc-gen-go-errors/main.go)

**Protobuf 定义如下：**

```protobuf
// ERROR .
enum ERROR {
  option (errors.default_code) = 500;

  // 未知错误
  UNKNOWN = 0 [(errors.code) = 500];
}
```

**生成的代码如下：**

```go

// Code generated by protoc-gen-go-errors. DO NOT EDIT.

package my_package

import (
	fmt "fmt"
	errors "github.com/go-kratos/kratos/v2/errors"
	strconv "strconv"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the kratos package it is being compiled against.
const _ = errors.SupportPackageIsVersion1

var ERROR_http_code = map[string]int{
	"UNKNOWN": 500,
}

// ERROR .
func (x ERROR) HTTPCode() int {
	if v, ok := ERROR_http_code[x.String()]; ok {
		return v
	}
	return 0
}

// 未知错误
func IsUnknown(err error) bool {
	if err == nil {
		return false
	}
	e := errors.FromError(err)
	return e.Reason == ERROR_UNKNOWN.String() && e.Code == 500
}

// 未知错误
func ErrorUnknown(format string, args ...interface{}) *errors.Error {
	e := errors.New(500, ERROR_UNKNOWN.String(), fmt.Sprintf(format, args...))
	e.Metadata = map[string]string{"reason": strconv.Itoa(int(ERROR_UNKNOWN.Number()))}
	return e
}

// 未知错误
func DefaultUnknown_Error() *errors.Error {
	e := errors.New(500, ERROR_UNKNOWN.String(), "未知错误")
	e.Metadata = map[string]string{"reason": strconv.Itoa(int(ERROR_UNKNOWN.Number()))}
	return e
}

```