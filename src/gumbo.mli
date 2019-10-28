open! Base
open! Import

module Node : sig
  type 't t =
    { tagname : string
    ; attrs : string Map.M(String).t
    ; children : 't list
    }
  [@@deriving fields, sexp_of]
end

type t =
  | Node of t Node.t
  | Text of string
[@@deriving sexp_of]

val parse : string -> t list
