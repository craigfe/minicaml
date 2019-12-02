# minicaml

[Leggi qui in italiano](https://github.com/0x0f0f0f/minicaml/blob/master/README-it.md)

**minicaml** is a small, purely functional interpreted programming language with
a didactical purpose. I wrote **minicaml** for the **Programming 2** course at
the University of Pisa, taught by Professors Gianluigi Ferrari and Francesca
Levi. It is based on the teachers'
[minicaml](http://pages.di.unipi.it/levi/codice-18/evalFunEnvFull.ml), an
evaluation example to show how interpreters work. It is an interpreted subset of
Caml, with eager evaluation and only local (`let-in`) declaration statements. I
have added a simple parser and lexer made with menhir and ocamllex ([learn
more](https://v1.realworldocaml.org/v1/en/html/parsing-with-ocamllex-and-menhir.html)).
I have also added a simple REPL that show each reduction step that is done in
evaluating an expression. I'd like to implement a simple compiler and abstract
machine for this project.

**minicaml** only implements basic data types (integers and booleans) and will
never be a full programming language intended for real world usage. **minicaml's only
purpose is to help students get a grasp of how interpreters and programming
languages work**.

## Installation
I will release a binary file (no need to compile) in the near future. To
install, you need to have `opam` (OCaml's package manager) and a recent OCaml
distribution installed on your system.

```bash
# clone the repository
git clone https://github.com/0x0f0f0f/minicaml
# cd into it
cd minicaml
# install dependencies
opam install dune menhir ANSITerminal
# compile
make
# run
make run
```

## Usage

Run `make run` to run a REPL. The REPL shows the AST equivalentof each submitted
expression, and each reduction step in the evaluation is shown. It also signals
syntactical and semantical errors.
