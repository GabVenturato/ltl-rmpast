# LTL Past Remover
Exploit LTL and LTL+Past expressive equivalence to remove past from an LTL+Past
formula, producing an LTL equisatisfiable one.

## BNFC
To build and test the [BNFC](https://bnfc.digitalgrammars.com/) grammar file
used to generate the first working parser prototype, run:
```
cd bnfc
bnfc -d -m --haskell Formula.cf
make
./Formula/Test
```