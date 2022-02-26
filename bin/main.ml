module DB = Blog_storage.Open(Blog_storage.TestDB)
module Bag = Blog_storage.Bag
module Blog = Blog_query.Compile(DB)
open Blog

let iter_rows f =
  Bag.fold () f (fun () () -> ())

let () =
  Printf.printf "Posts of author foo\n";
  posts_of_author "foo" |> run |> iter_rows (
    fun ((uuid,title),date) -> Printf.printf "%s: %s (%d)\n" uuid title date
  );

  Printf.printf "Posts with tag DB\n";
  posts_of_tag "DB" |> run |> iter_rows (
    fun ((title, _),_) -> Printf.printf "%s\n" title
  );

  Printf.printf "Authors commenting their posts\n";
  names_of_authors_commenting_their_posts |> run |> iter_rows (
    Printf.printf "%s\n"
  )
