local C = {
  { "Replace {{X}} with {{ X }} in jinja template", "%s/{{\\(.[^ ]*\\)}}/{{ \\1 }}/g" },
}

return C
