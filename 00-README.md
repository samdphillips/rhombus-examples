# Kicking the tires of Rhombus

**NOTE** The Rhombus proposal is not stable.  This example should be considered a point in time example.  I may or may not update this to reflect newer versions fo the proposal.

## 2021/08/04
This is a translation of a kind of scraping script I've written in Racket.

Some notes:
- I'm avoiding making new syntax, some things (`with-handlers*`, `with-disposable`) could look nicer with 
  special syntax.  I'm not quite up to speed on the macro system, and I wanted to get something working.
- `shim.rkt` avoids the problem where requiring `racket/base` will shadow the rhombus names and then 
  Bad Things(TM) start happening.  Like none of the infix operators work and syntax like `if` and `define` 
  get shadowed.
- Racket identifiers are not the same as Rhombus identifiers so a lot has to be renamed.