# LTL Past Remover
Exploit LTL and LTL+Past expressive equivalence to remove past from an LTL+Past
formula, producing an LTL equisatisfiable one.

## Compile
To try the past remover use [Cabal](https://www.haskell.org/cabal/) with `cabal run` or `cabal v2-run`.

## BNFC
To build and test the [BNFC](https://bnfc.digitalgrammars.com/) grammar file
used to generate the first working parser prototype, run:
```
cd bnfc
bnfc -d -m --haskell Formula.cf
make
./Formula/Test
```