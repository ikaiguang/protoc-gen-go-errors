var {{ .EnumName }}_http_code = map[string]int{
{{ range .Errors }}
	"{{ .Value }}": {{ .HTTPCode }},
{{- end }}
}

func (x {{ .EnumName }}) HTTPCode() int {
	if v, ok := {{ .EnumName }}_http_code[x.String()]; ok {
		return v
	}
	return {{ .DefaultCode }}
}

{{ range .Errors }}

{{ if .HasComment }}{{ .Comment }}{{ end -}}
func DefaultError{{ .CamelValue }}() *errors.Error {
	 e := errors.New({{ .HTTPCode }}, {{ .Name }}_{{ .Value }}.String(), {{ .OriginComment }})
	 e.Metadata = map[string]string{"reason": strconv.Itoa(int({{ .Name }}_{{ .Value }}.Number()))}
     return e
}

{{- end }}
