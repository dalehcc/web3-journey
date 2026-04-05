## Storage Factory

Built while following the [Cyfrin Updraft](https://updraft.cyfrin.io) Solidity course.
Credit to Patrick Collins & the Cyfrin team for the original code and curriculum.

All basic functions are included in SimpleStorage contract, such as store(), retrieve(), addPerson(). The main goal is to store a favorite number.

On top of it, the core idea of StorageFactory contract is to show that a contract can deploy and manage other contracts programatically by "import".

In addition, AddFiveStorage contract is to present the idea of inheritance. To override a function in parent contract, "virtual"/"override" keyword can be assigned to parent/child contracts respectively.