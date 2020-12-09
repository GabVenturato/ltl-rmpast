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

module LtlRmPast where

import Formula.Abs

subPast :: Formula -> Formula
subPast f = case f of
  p@(Atom _) -> p
  -- propositional operators
  Not phi -> Not $ subPast phi
  And phi1 phi2 -> And (subPast phi1) (subPast phi2)
  Or phi1 phi2 -> Or (subPast phi1) (subPast phi2)
  -- past temporal operators
  Yesterday phi -> Atom $ FormulaLabel $ Yesterday (subPast phi)
  Wyesterday phi -> Atom $ FormulaLabel $ Wyesterday (subPast phi)
  Since phi1 phi2 -> Atom $ FormulaLabel $ Since (subPast phi1) (subPast phi2)
  Triggered phi1 phi2 -> subPast $ Not $ Since (Not phi1) (Not phi2)
  Once phi -> subPast $ Since (Bool BooleanTrue) phi
  Historically phi -> subPast $ Not $ Once (Not phi)
  -- future temporal operators
  Next phi -> Next $ subPast phi
  Eventually phi -> Eventually $ subPast phi
  Always phi -> Always $ subPast phi
  Until phi1 phi2 -> Until (subPast phi1) (subPast phi2)
  Release phi1 phi2 -> Release (subPast phi1) (subPast phi2)