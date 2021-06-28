# LTL Past Remover

Exploit LTL and LTL+Past expressive equivalence to remove past from an LTL+Past
formula, producing an LTL equisatisfiable one.

## Compile

The project relies on [stack](https://www.haskellstack.org). Therefore, simply run `stack build` to build the project, and `stack exec ltl-rmpast` to run it.

Although the preferred way is to use `stack`, one could also use `cabal build` and  `cabal run ltl-rmpast`.

## BNFC

To build and test the [BNFC](https://bnfc.digitalgrammars.com/) grammar file
used to generate the first working parser prototype, run:

```bash
cd bnfc
bnfc -d -m --haskell Formula.cf
make
./Formula/Test
```
