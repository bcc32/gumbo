open! Base
open! Import

type node =
  { tagname : string
  ; attrs : string Map.M(String).t
  ; children : t list
  }

and t =
  | Node of node
  | Text of string
[@@deriving sexp_of]
