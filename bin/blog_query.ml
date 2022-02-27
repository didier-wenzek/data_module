open Data_module

module Compile(Schema: Blog_schema.S) = struct
  open Schema
  include Query_refimpl.Make(Schema)

  module Author = struct
    include Schema.Author
    let posts = inverse Post.author
    let comments = inverse Comment.author
  end

  module Post = struct
    include Schema.Post
    let comments = inverse Comment.post
  end

  let posts_of_author name =
    let post, uuid, title, date = var4 () in
    select (!$ uuid $ title $ date) [
      !! post (Post.author <=> Author.name) (value name);
      !! post Post.uuid uuid;
      !! post Post.title title;
      !! post Post.date date;
    ]

  let posts_of_tag tag =
    let post, title, author, date = var4 () in
    select (!$ title $ author $ date) [
      !!@ post posts;
      !! post Post.tags (value tag);
      !! post (Post.author <=> Author.name) author;
      !! post Post.date date;
      !! post Post.title title;
    ]
    
  (* FIXME The result of this query cannot be used because abstract. *)
  let authors_commenting_their_posts =
    let author = var1 () in
    select all [
      !! author (Author.posts <=> Post.comments <=> Comment.author) author
    ]
    
  (* FIXME The system fails to find a plan.
     Indeed there is no index from authors to their posts nor to their comments. *)
  let authors_commenting_their_posts_bis =
    let author, name = var2 () in
    select all [
      !!@ author authors;
      !! author (Author.posts <=> Post.comments <=> Comment.author) author;
      !! author Author.name name;
    ]
    
  let names_of_authors_commenting_their_posts =
    let author, name, comment = var3 () in
    select (!$ name) [
      !!@ comment comments;
      !! comment Comment.author author;
      !! comment (Comment.post <=> Post.author) author;
      !! author Author.name name;
    ]
end
