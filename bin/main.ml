open! Core
open! Import

let input =
  match%map_open.Command.Let_syntax anon (maybe ("FILE" %: string)) with
  | None | Some "-" -> fun () -> In_channel.input_all In_channel.stdin
  | Some file -> fun () -> In_channel.read_all file
;;

let () =
  Command.basic
    ~summary:"Read HTML and print it as a sexp"
    ~readme:(fun () ->
      "Read HTML from a file and print its sexp representation to standard output.  If \
       FILE is -, read from standard input instead of a file.")
    (let%map.Command.Let_syntax input = input in
     fun () ->
       Gumbo.parse (input ())
       |> List.iter ~f:(fun gumbo -> gumbo |> [%sexp_of: Gumbo.t] |> print_s))
  |> Command.run
;;
