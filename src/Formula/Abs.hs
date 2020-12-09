-- Copyright (c) 2020 Gabriele Venturato
-- 
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Formula.Abs where

import Prelude (Char, Double, Int, Integer, String)
import qualified Prelude as C (Eq, Ord, Show, Read)

data Boolean = BooleanTrue | BooleanFalse
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Label = StringLabel String | FormulaLabel Formula
  deriving (C.Eq, C.Ord, C.Show, C.Read)

data Formula
    = Implies Formula Formula
    | Implied Formula Formula
    | Iff Formula Formula
    | Until Formula Formula
    | Release Formula Formula
    | Since Formula Formula
    | Triggered Formula Formula
    | And Formula Formula
    | Or Formula Formula
    | Next Formula
    | Eventually Formula
    | Always Formula
    | Yesterday Formula
    | Wyesterday Formula
    | Once Formula
    | Historically Formula
    | Not Formula
    | Atom Label
    | Bool Boolean
  deriving (C.Eq, C.Ord, C.Show, C.Read)