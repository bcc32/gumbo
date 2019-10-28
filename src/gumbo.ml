open! Base
open! Import

module Node = struct
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

let rec sexp_of_t t =
  match t with
  | Node node -> Node.sexp_of_t sexp_of_t node
  | Text t -> Sexp.Atom t
;;

let rec of_soup (soup : _ Soup.node) : t =
  match Soup.element soup with
  | None -> Text (Soup.to_string soup)
  | Some elt ->
    let tagname = Soup.name elt in
    let attrs =
      Soup.fold_attributes (fun acc k v -> (k, v) :: acc) [] elt
      |> Map.of_alist_exn (module String)
    in
    let children = soup |> Soup.children |> Soup.to_list |> List.map ~f:of_soup in
    Node { Node.tagname; attrs; children }
;;

let parse string =
  Soup.parse string |> Soup.children |> Soup.to_list |> List.map ~f:of_soup
;;
