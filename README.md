Exploring the idea to use modules à la SML/OCaml to build a database as an assemblage of data modules.

Can we use OCaml modules to encapsulate datasets with all the mechanisms and information so a query engine can:

* efficiently process datasets that have been independly designed,
* abstract the queries from the actual internal representation of the data,
* leverage cost information and indexes to build efficient execution plan.

See here for [a more contextual motivation](https://github.com/didier-wenzek/blog/blob/main/src/001_motivation.md)

