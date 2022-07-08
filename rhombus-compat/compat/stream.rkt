#lang rhombus

import:
  rhombus/macro open
  racket/stream:
    rename:
      #{stream-cons}  as cons
      #{stream-count} as count
      #{empty-stream} as empty

export:
  Stream
  all_in(stream)

annotation.macro 'Stream':
  values(annotation_ct.pack_predicate('stream.#{stream?}',
                                      '(($(dot_ct.provider_key), stream_dot_provider))'),
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

