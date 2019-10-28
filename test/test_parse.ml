open! Core_kernel
open! Import
open Gumbo

let%expect_test "basic HTML" =
  parse
    {|
<html>
    <head><title>Title</title></head>
    <body>
        <h1>Hello, World!</h1>
    </body>
</html>
|}
  |> [%sexp_of: t list]
  |> print_s;
  [%expect
    {|
    ((
      (tagname html)
      (attrs ())
      (children (
        ((tagname head)
         (attrs ())
         (children (((tagname title) (attrs ()) (children (Title))))))
        "\n    "
        ((tagname body)
         (attrs ())
         (children (
           "\n        "
           ((tagname h1) (attrs ()) (children ("Hello, World!")))
           "\n    \n\n"))))))) |}]
;;
