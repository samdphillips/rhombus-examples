#lang rhombus

import:
  net/url:
    prefix url
    rename:
      #{string->url} ~to from_string
      #{url-path} ~to path
      #{url-query} ~to query
      #{path/param-path} ~to param_path

export: url