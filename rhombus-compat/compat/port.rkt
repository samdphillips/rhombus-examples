#lang rhombus

import:
  rhombus/macro open
  racket/base as r:
    rename:
      #{close-input-port}  as close_input_port
      #{close-output-port} as close_output_port

export:
  port_dot_provider
  Port

fun close_port(p):
 if r.#{input-port?}(p)
 | r.close_input_port(p)
 | r.close_output_port(p)

fun is_port(p): r.#{input-port?}(p) || r.#{output-port?}(p)

annotation.macro 'Port':
  values(annotation_ct.pack_predicate('is_port',
                                      '(($(dot_ct.provider_key), port_dot_provider))'),
         '')

dot.macro 'port_dot_provider $left $dot $right':
  match right
  | 'display':       'fun(arg): r.display(arg, $left)'
  | 'match':         'fun(arg): r.regexp_match(arg, $left)'
  | 'close':         'fun (): close_port($left)'
  // this one doesn't work for some reason
  | 'readline':      'fun (): r.#{read-line}($left)'

