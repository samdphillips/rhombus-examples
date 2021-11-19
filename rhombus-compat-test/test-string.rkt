#lang rhombus
// Tests passes if all results are #true

import:
  "../rhombus-compat/compat/string.rkt":           no_prefix   // for static s[range]
  // "../rhombus-compat/compat/string-private.rkt":   no_prefix   // for String and dot
  "../rhombus-compat/compat/range.rkt":            no_prefix   // -- and --=
  "../rhombus-compat/compat/map-ref.rkt":          no_prefix   // for dynamic s[range]
  rhombus/macro:                                   no_prefix
// Used as annotation
def s : "foobar" :: String

// Used as predicate
("foo" is_a String)===#true
(42    is_a String)===#false

// Reference
s[0]===#{#\f}
s[2--3]==="o"
s[2--=3]==="ob"
s[1--end]==="oobar"
s[--2]==="fo"
s[--=2]==="foo"

// Dynamic reference
def t : "bar"
t[0]===#{#\b}

// Binding syntax
def middle(String(a,_,b)): [a,b]
middle("xyz")===[#{#\x},#{#\z}]

// Mutation
// s[1]=#{#\a}
// s==="fao"

// Dot
s.length
                                  
                                  