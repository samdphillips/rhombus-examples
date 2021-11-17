#lang rhombus

export: 
  port_dot_provider
  Port

import:
  rhombus/macro: no_prefix
  racket/control
  racket/base:
    prefix r
    rename:
      #{call/cc} ~to callcc
      #{regexp-match} ~to regexp_match
      #{close-input-port} ~to close_input_port
      #{close-output-port} ~to close_output_port
      #{current-custodian} ~to current_custodian
      #{custodian-shutdown-all} ~to custodian_shutdown_all
  
fun close_port(p):
 if r.#{input-port?}(p)
 | r.close_input_port(p)
 | r.close_output_port(p)


fun is_port(p): r.#{input-port?}(p) || r.#{output-port?}(p)

 
annotation.macro 'Port:
  annotation_ct.pack_predicate('is_port,
                               '(($(dot_ct.provider_key), port_dot_provider)))
dot.macro '(port_dot_provider $left $dot $right):
  match right
  // One argument functions
  | 'display:       '(fun(arg):(r.display(arg,$left)))
  | 'match:         '(fun(arg):(r.regexp_match(arg,$left)))
  | 'close:         '(fun (): close_port($left))
  // this one doesn't work for some reason
  | 'readline:      '(fun (): r.#{read-line}($left))