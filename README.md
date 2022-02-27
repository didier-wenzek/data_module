Exploring the idea to use modules à la SML/OCaml to build a database as an assemblage of data modules.

An OCaml module is a compilation unit which encapsulates types and values behind a signature that defines what is accessible from the outside.
The signature also gives the types of the public values, data and functions, so these values can be used from other modules and the modules combined into larger ones.
Notably, a signature can abstract the actual type of values, by not providing the actual representations,
still letting the other modules use these values consistently.
For instance, in the context of a database, one can imagine a module that contains indexed values and exposes functions to efficiently access these values
without providing the internal representation of the dataset and indexes.


The idea is to __abstract a dataset__ as a module that provides not only the data but also the mechanisms to process these data as well type and cost information:

* inter-related values - the __actual content__ of the dataset,
* a __schema__ describing the types of these values and their relationships,
* __accessor functions__ to efficiently retrieve specific subset of the values,
* indexes and caches - abstracted by the accessor functions,
* __cost information__ for the accessor functions.
