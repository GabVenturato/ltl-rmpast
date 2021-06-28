-- Copyright Gabriele Venturato (c) 2021

-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.

--     * Redistributions in binary form must reproduce the above
--       copyright notice, this list of conditions and the following
--       disclaimer in the documentation and/or other materials provided
--       with the distribution.

--     * Neither the name of Gabriele Venturato nor the names of other
--       contributors may be used to endorse or promote products derived
--       from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

--
-- This Happy file was machine-generated by the BNF converter, and later
-- slightly modified.
--

{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Formula.Par where
import qualified Formula.Abs
import Formula.Lex
}

%name pFormula Formula
%name pFormula2 Formula2
%name pFormula4 Formula4
%name pFormula5 Formula5
%name pFormula1 Formula1
%name pFormula3 Formula3
%name pBoolean Boolean
-- no lexer declaration
%monad { Either String } { (>>=) } { return }
%tokentype {Token}
%token
  '!' { PT _ (TS _ 1) }
  '&' { PT _ (TS _ 2) }
  '&&' { PT _ (TS _ 3) }
  '(' { PT _ (TS _ 4) }
  ')' { PT _ (TS _ 5) }
  '->' { PT _ (TS _ 6) }
  '/\\' { PT _ (TS _ 7) }
  '<-' { PT _ (TS _ 8) }
  '<->' { PT _ (TS _ 9) }
  'F' { PT _ (TS _ 10) }
  'False' { PT _ (TS _ 11) }
  'G' { PT _ (TS _ 12) }
  'H' { PT _ (TS _ 13) }
  'O' { PT _ (TS _ 14) }
  'P' { PT _ (TS _ 15) }
  'R' { PT _ (TS _ 16) }
  'S' { PT _ (TS _ 17) }
  'T' { PT _ (TS _ 18) }
  'True' { PT _ (TS _ 19) }
  'U' { PT _ (TS _ 20) }
  'X' { PT _ (TS _ 21) }
  'Y' { PT _ (TS _ 22) }
  'Z' { PT _ (TS _ 23) }
  '\\/' { PT _ (TS _ 24) }
  '|' { PT _ (TS _ 25) }
  '||' { PT _ (TS _ 26) }
  L_Ident  { PT _ (TV $$) }

%%

Ident :: { Formula.Abs.Label }
Ident  : L_Ident { Formula.Abs.StringLabel $1 }

Formula :: { Formula.Abs.Formula }
Formula : Formula '->' Formula1 { Formula.Abs.Implies $1 $3 }
        | Formula '<-' Formula1 { Formula.Abs.Implied $1 $3 }
        | Formula '<->' Formula1 { Formula.Abs.Iff $1 $3 }
        | Formula1 { $1 }

Formula2 :: { Formula.Abs.Formula }
Formula2 : Formula2 'U' Formula3 { Formula.Abs.Until $1 $3 }
         | Formula2 'R' Formula3 { Formula.Abs.Release $1 $3 }
         | Formula2 'S' Formula3 { Formula.Abs.Since $1 $3 }
         | Formula2 'T' Formula3 { Formula.Abs.Triggered $1 $3 }
         | Formula2 '&' Formula3 { Formula.Abs.And $1 $3 }
         | Formula2 '&&' Formula3 { Formula.Abs.And $1 $3 }
         | Formula2 '/\\' Formula3 { Formula.Abs.And $1 $3 }
         | Formula2 '|' Formula3 { Formula.Abs.Or $1 $3 }
         | Formula2 '||' Formula3 { Formula.Abs.Or $1 $3 }
         | Formula2 '\\/' Formula3 { Formula.Abs.Or $1 $3 }
         | Formula3 { $1 }

Formula4 :: { Formula.Abs.Formula }
Formula4 : 'X' Formula4 { Formula.Abs.Next $2 }
         | 'F' Formula4 { Formula.Abs.Eventually $2 }
         | 'G' Formula4 { Formula.Abs.Always $2 }
         | 'Y' Formula4 { Formula.Abs.Yesterday $2 }
         | 'Z' Formula4 { Formula.Abs.Wyesterday $2 }
         | 'O' Formula4 { Formula.Abs.Once $2 }
         | 'P' Formula4 { Formula.Abs.Once $2 }
         | 'H' Formula4 { Formula.Abs.Historically $2 }
         | '!' Formula4 { Formula.Abs.Not $2 }
         | Formula5 { $1 }

Formula5 :: { Formula.Abs.Formula }
Formula5 : Ident { Formula.Abs.Atom $1 }
         | Boolean { Formula.Abs.Bool $1 }
         | '(' Formula ')' { $2 }

Formula1 :: { Formula.Abs.Formula }
Formula1 : Formula2 { $1 }

Formula3 :: { Formula.Abs.Formula }
Formula3 : Formula4 { $1 }

Boolean :: { Formula.Abs.Boolean }
Boolean : 'True' { Formula.Abs.BooleanTrue }
        | 'False' { Formula.Abs.BooleanFalse }
{

happyError :: [Token] -> Either String a
happyError ts = Left $
  "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ (prToken t) ++ "'"

myLexer = tokens
}