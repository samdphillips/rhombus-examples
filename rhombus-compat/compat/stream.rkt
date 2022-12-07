#lang rhombus

import:
  rhombus/meta open
  racket/stream:
    rename:
      #{stream-cons}  as cons
      #{stream-count} as count
      #{empty-stream} as empty

export:
  all_from(.stream)
  Stream

annot.macro 'Stream':
  values(annot_meta.pack_predicate('stream.#{stream?}',
                                   '(($(statinfo_meta.dot_provider_key),
                                      stream_dot_provider))'),
         '')

// XXX: if $left is annotated Stream.of(X) is there a way to access X and
// push it into the RHS of the expansion cases?
dot.macro 'stream_dot_provider $left $dot $right':
  match right
  | 'is_empty': 'stream.#{stream-empty?}($left)'
  | 'first':    'stream.#{stream-first}($left)'
  | 'rest':     'stream.#{stream-rest}($left)'
  | 'take':     'fun (i) -: Stream: stream.#{stream-take}($left, i)'
  | 'to_list':  'fun () -: List: stream.#{stream->list}($left)'
  | 'count':    'fun (p): stream.count(p, $left)'

