#lang rhombus
///
/// 4.4. String
///

// Section "4.4. Strings" in the references:
// https://docs.racket-lang.org/reference/strings.html

//// Goals
//  - Short names
//       The intended usage is:
//            import: compat/string: prefix string
//       Then string.append, string.= etc are available.

//  - String annotation
//       s.name becomes  (string-name s), when s is declared to be a String
//  - string reference, s[ ] can be used for indexing as well as substrings

// Note: The list of renames are made explicit below.
//       It helps when grepping for names.


import:
  rhombus/macro:        no_prefix // for defining dot provider
  "string-private.rkt": no_prefix

  racket/base:
    prefix base
    rename:
      // 4.4.1 String constructors, selectors and mutators
      #{string?}                  ~to is_string
      #{make-string}              ~to make
      #{string}                   ~to string
      #{string->immutable-string} ~to to_immutable
      #{string-length}            ~to string_length   // exported as length
      #{string-ref}               ~to ref
      #{string-set!}              ~to set
      #{substring}                ~to sub
      #{string-copy}              ~to copy
      #{string-copy!}             ~to copy_bang       // todo - convention for bang?
      #{string-fill!}             ~to fill            // todo - convention for bang?
      #{string-append}            ~to string_append   // exported as append
      #{string-append-immutable}  ~to append_immutable
      #{string->list}             ~to to_list
      #{list->string}             ~to from_list   
      #{build-string}             ~to build_string

      // 4.4.2 String comparisons
      #{string=?}                 ~to string_equal         // exported as =
      #{string<?}                 ~to string_less          // exported as <
      #{string<=?}                ~to string_less_equal    // exported as <=
      #{string>?}                 ~to string_greater       // exported as >
      #{string>=?}                ~to string_greater_equal // exported as >=
      #{string-ci=?}              ~to ci_equal
      #{string-ci<?}              ~to ci_less
      #{string-ci<=?}             ~to ci_less_equal
      #{string-ci>?}              ~to ci_greater
      #{string-ci>=?}             ~to ci_greater_equal
      
      // 4.4.3 String Conversions
      #{string-upcase}            ~to upcase
      #{string-downcase}          ~to downcase
      #{string-titlecase}         ~to titlecase
      #{string-foldcase}          ~to foldcase
      #{string-normalize-nfd}     ~to normalize_nfd
      #{string-normalize-nfkd}    ~to normalize_nfkd
      #{string-normalize-nfc}     ~to normalize_nfc
      #{string-normalize-nfkc}    ~to normalize_nfkc
      
      // 4.4.4 Locale-Specific String Operations
      #{string-locale=?}          ~to locale_equal
      #{string-locale<?}          ~to locale_less
      #{string-locale>?}          ~to locale_greater
      #{string-locale-ci=?}       ~to locale_ci_equal
      #{string-locale-ci<?}       ~to locale_ci_less
      #{string-locale-ci>?}       ~to locale_ci_greater
      #{string-locale-upcase}     ~to locale_upcase
      #{string-locale-downcase}   ~to locale_downcase

  racket/string:
        prefix string
        rename:
          // 4.4.5 Additional String Functions
          #{string-append*}          ~to appends  // todo: * = s ?
          #{string-join}             ~to join
          #{string-normalize-spaces} ~to normalize_spaces
          #{string-replace}          ~to replace
          #{string-split}            ~to split
          #{string-trim}             ~to trim
          #{non-empty-string?}       ~to is_non_empty
          #{string-contains?}        ~to contains   // todo: is_contains doesn't sound right
          #{string-prefix?}          ~to is_prefix
          #{string-suffix?}          ~to is_suffix
          
  racket/format:
        prefix format
        rename:
          // 4.4.6 Converting Values to Strings
          #{~a}          ~to tilde_a
          #{~v}          ~to tilde_v
          #{~s}          ~to tilde_s
          #{~e}          ~to tilde_e
          #{~r}          ~to tilde_r
          #{~.a}         ~to tilde_dot_a
          #{~.v}         ~to tilde_dot_v
          #{~.s}         ~to tilde_dot_s
      
export:
  // The annotation and reference
  all_from("string-private.rkt") // does not export String and dots ???
  String
  string_dot_provider
  
  // 4.4.1 String constructors, selectors and mutators
  rename:
    base.is_string ~to is_string
    base.string ~to string
    base.make ~to make
    base.to_immutable ~to to_immutable
    base.ref ~to ref
    base.set ~to set
    base.sub ~to sub
    base.copy ~to copy
    base.copy_bang ~to  copy_bang
    base.fill ~to fill
    base.append_immutable ~to append_immutable
    base.to_list ~to to_list
    base.from_list ~to from_list
    base.build_string ~to build_string
    base.string_length ~to length
    base.string_append ~to append
    // 4.4.2 String comparisons
    base.string_equal         ~to =
    base.string_less          ~to <
    base.string_less_equal    ~to <=
    base.string_greater       ~to >
    base.string_greater_equal ~to >=
    base.ci_equal             ~to ci_equal
    base.ci_less              ~to ci_less
    base.ci_less_equal        ~to ci_less_equal
    base.ci_greater           ~to ci_greater
    base.ci_greater_equal     ~to ci_greater_equal
    
    // 4.4.3 String Conversions
    base.upcase         ~to upcase
    base.downcase       ~to downcase
    base.titlecase      ~to titlecase
    base.foldcase       ~to foldcase
    base.normalize_nfd  ~to normalize_nfd
    base.normalize_nfkd ~to normalize_nfkd
    base.normalize_nfc  ~to normalize_nfc
    base.normalize_nfkc ~to normalize_nfkc

    // 4.4.4 Locale-Specific String Operations
    base.locale_equal      ~to locale_equal
    base.locale_less       ~to locale_less
    base.locale_greater    ~to locale_greater
    base.locale_ci_equal   ~to locale_ci_equal
    base.locale_ci_less    ~to locale_ci_less
    base.locale_ci_greater ~to locale_ci_greater
    base.locale_upcase     ~to locale_upcase
    base.locale_downcase   ~to locale_downcase
    // 4.4.5 Additional String Functions
    string.appends          ~to appends
    string.join             ~to join
    string.normalize_spaces ~to normalize_spaces
    string.replace          ~to replace
    string.split            ~to split
    string.trim             ~to trim
    string.is_non_empty     ~to is_non_empty
    string.contains         ~to contains
    string.is_prefix        ~to is_prefix
    string.is_suffix        ~to is_suffix
    
    // 4.4.6 Converting Values to Strings
    format.tilde_a     ~to tilde_a
    format.tilde_v     ~to tilde_v
    format.tilde_s     ~to tilde_s
    format.tilde_e     ~to tilde_e
    format.tilde_r     ~to tilde_r
    format.tilde_dot_a ~to tilde_dot_a
    format.tilde_dot_v ~to tilde_dot_v
    format.tilde_dot_s ~to tilde_dot_s



/// Helpers
fun stringify(x): if is_string(x) | x | base.string(x)
def is_string: base.is_string
def is_string_empty(x) : base.string_length(x)==0

/// String Concatenation

// Note: An n-ary string contenation operator would be better.
operator (a ++ b):
  ~associativity: ~right  
  ~stronger_than: && ||                  
  base.string_append(stringify(a),stringify(b))

// String Dot Provider
// If s is annotated with String, then we can use s.length etc

// Note: Don't use `x is_a String` in the predicate. That's an infinite loop.
annotation.macro 'String:
  annotation_ct.pack_predicate('is_string,
                               '(($(dot_ct.provider_key), string_dot_provider)))

def ref: "ref"

dot.macro '(string_dot_provider $left $dot $right):
  // Note: The search for the right function is linear.
  //       Place most often used function at the top.
  match right
  // One argument functions
  | 'to_immutable:    '(base.to_immutable($left))
  | 'length:          '(base.string_length($left))
  | 'is_non_empty:    '(string.is_non_empty($left))
  | 'is_empty:        '(is_string_empty($left))
  | 'copy:            '(base.copy($left))
  | 'to_list:         '(base.to_list($left))
  | 'upcase:          '(base.upcase($left))      // todo: annotate that the result is a String
  | 'downcase:        '(base.downcase($left))
  | 'titlecase:       '(base.titlecase($left))
  | 'foldcase:        '(base.foldcase($left))
  | 'normalize_nfd:   '(base.normalize_nfd($left))
  | 'normalize_nfkd:  '(base.normalize_nfkd($left))
  | 'normalize_nfc:   '(base.normalize_nfc($left))
  | 'normalize_nfkc:  '(base.normalize_nfkc($left))
  | 'locale_upcase:   '(base.locale_upcase($left))      
  | 'locale_downcase: '(base.locale_downcase($left))
  | 'normalize_spaces: '(string.normalize_spaces($left))  // todo: other arguments?
  | 'split:            '(string.split($left))  // todo: other arguments?
  | 'trim:             '(string.trim($left))  // todo: other arguments?
  
  
  // More arguments
  | 'ref:          '(fun (k): base.ref($left,k))
  | 'sub:          '(fun (start, end=#false):
                       if end
                       | base.sub($left,start,end)
                       | base.sub($left,start))
  | 'append:       '(fun (more): string.appends(cons($left,[more]))) // variadic? how?
  | 'join:         '(fun (more): string.join(cons($left,more)))      // s.join(["bar","baz"])
  | 'replace:      '(fun (from,to): string.replace($left,from,to))   // s.replace("o","x")
  | 'contains:     '(fun (needle): string.contains($left,needle))
  | 'is_prefix:    '(fun (needle): string.is_prefix($left,needle))
  | 'is_suffix:    '(fun (needle): string.is_suffix($left,needle))
                   

// > val s: "foo" :: String
// > s.length
// 3
