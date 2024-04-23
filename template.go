package main

import (
	"bytes"
	_ "embed"
	"text/template"
)

//go:embed errorsTemplate.tpl
var errorsTemplate string

//go:embed errorsTemplateCustom.tpl
var errorsTemplateCustom string

type errorInfo struct {
	Name          string
	Value         string
	HTTPCode      int
	CamelValue    string
	Comment       string
	HasComment    bool
	OriginComment string
}

type errorWrapper struct {
	EnumName    string
	DefaultCode int
	Errors      []*errorInfo
}

func (e *errorWrapper) execute() string {
	buf := new(bytes.Buffer)
	tmpl, err := template.New("errors").Parse(errorsTemplate)
	if err != nil {
		panic(err)
	}
	if err := tmpl.Execute(buf, e); err != nil {
		panic(err)
	}
	return buf.String()
}

func (e *errorWrapper) executeCustom() string {
	buf := new(bytes.Buffer)
	tmpl, err := template.New("errors").Parse(errorsTemplateCustom)
	if err != nil {
		panic(err)
	}
	if err := tmpl.Execute(buf, e); err != nil {
		panic(err)
	}
	return buf.String()
}
