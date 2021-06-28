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