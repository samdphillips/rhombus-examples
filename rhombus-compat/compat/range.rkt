#lang rhombus

import:
  "range-private.rkt": no_prefix

export:
  end
  --
  --=

def end : #false

operator
| (a -- b) : #{make-range}(a,b)
| (  -- b) : #{make-range}(#false,b)
             
operator
| (a --= b) : #{make-range}(a,b+1)
| (  --= b) : #{make-range}(#false,b+1)
