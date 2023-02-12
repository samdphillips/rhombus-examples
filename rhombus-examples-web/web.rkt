#lang rhombus

import:
  "web/private/disposable.rkt" as d
  "web/private/racket.rkt" as rkt
  "web/private/http.rkt"
  "web/private/keyring.rkt"
  "web/private/url.rkt"

def user_name: rkt.argv[0]
def service_name: rkt.argv[1]
def request_url_s: rkt.argv[2]

def request_url:
  url.string_to_url(request_url_s)

// keyring_auth ::
//   (Url Headers Query -> String String) AuthProc -> AuthProc
// AuthProc:
//   https://docs.racket-lang.org/http-easy/index.html#%28def._%28%28lib._net%2Fhttp-easy..rkt%29._auth-procedure%2Fc%29%29
//
// This function handles credential lookup in a keyring
fun keyring_auth(service_user_lookup, auth_proc):
  fun(a_url, headers, query):
    def (service_name, user_name): service_user_lookup(a_url, headers, query)
    def password: keyring.get_password(service_name, user_name)
    auth_proc(user_name, password)(a_url, headers, query)

def service_auth:
  keyring_auth(fun(u, h, q): values(service_name, user_name), http.basic_auth)

// A disposable value (https://docs.racket-lang.org/disposable/index.html) for
// making http requests with http-easy and closing the responses.
def http_request:
  rkt.make_keyword_procedure(
    // XXX: in a general case use a rest-arg but there is only one positional
    // argument we care about here.
    fun(kws, kwargs, uri):
      def max_tries: 10
      def pos_args: rkt.list(http.current_session(), uri)
      fun request_retry(tries_left):
        try:
          rkt.keyword_apply(http.session_request, kws, kwargs, pos_args)
          ~catch e :: Exn.Fail:
            if tries_left == 0
            | throw e
            | request_retry(tries_left - 1)
      d.disposable(
        fun(): request_retry(max_tries),
        http.response_close))

#//
keyring.default_keyring(
  keyring.make_keyring_from_string("keychain://"))

def job_doc:
  d.call_with_disposable(
    http_request(request_url,
                 ~auth: service_auth),
    http.response_json)

job_doc
