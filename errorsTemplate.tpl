{{ range .Errors }}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Is{{.CamelValue}}(err error) bool {
	if err == nil {
		return false
	}
	e := errors.FromError(err)
	return e.Reason == {{ .Name }}_{{ .Value }}.String() && e.Code == {{ .HTTPCode }}
}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Error{{ .CamelValue }}(format string, args ...interface{}) *errors.Error {
	  e := errors.New({{ .HTTPCode }}, {{ .Name }}_{{ .Value }}.String(), fmt.Sprintf(format, args...))
	  e.Metadata = map[string]string{"reason": strconv.Itoa(int({{ .Name }}_{{ .Value }}.Number()))}
	  return e
}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func Default{{ .CamelValue }}_Error() *errors.Error {
	 e := errors.New({{ .HTTPCode }}, {{ .Name }}_{{ .Value }}.String(), {{ .OriginComment }})
	 e.Metadata = map[string]string{"reason": strconv.Itoa(int({{ .Name }}_{{ .Value }}.Number()))}
     return e
}

{{- end }}
