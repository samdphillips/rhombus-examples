#lang rhombus

import:
  net/url:
    rename:
      #{string->url}     as from_string
      #{url-path}        as path
      #{url-query}       as query
      #{path/param-path} as param_path

export: url
