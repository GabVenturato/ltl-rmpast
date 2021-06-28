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

module LtlRmPast ( removePast ) where

import Formula.Abs

subPast :: Formula -> Formula
subPast f = case f of
  p@(Atom _)          -> p
  -- propositional operators
  Not phi             -> Not $ subPast phi
  And phi1 phi2       -> And (subPast phi1) (subPast phi2)
  Or phi1 phi2        -> Or (subPast phi1) (subPast phi2)
  -- past temporal operators
  Yesterday phi       -> Atom $ FormulaLabel $ Yesterday (subPast phi)
  Wyesterday phi      -> Atom $ FormulaLabel $ Wyesterday (subPast phi)
  Since phi1 phi2     -> Atom $ FormulaLabel $ Since (subPast phi1) (subPast phi2)
  Triggered phi1 phi2 -> subPast $ Not $ Since (Not phi1) (Not phi2)
  Once phi            -> subPast $ Since (Bool BooleanTrue) phi
  Historically phi    -> subPast $ Not $ Once (Not phi)
  -- future temporal operators
  Next phi            -> Next $ subPast phi
  Eventually phi      -> Eventually $ subPast phi
  Always phi          -> Always $ subPast phi
  Until phi1 phi2     -> Until (subPast phi1) (subPast phi2)
  Release phi1 phi2   -> Release (subPast phi1) (subPast phi2)

genSemantics :: Formula -> [Formula]
genSemantics f = case f of
  Atom (StringLabel _)        -> []
  p@(Atom (FormulaLabel phi)) -> case phi of
    Yesterday psi   ->  ySemantics p : genSemantics psi
    Wyesterday psi  ->  zSemantics p : genSemantics psi
    Since psi1 psi2 -> sSemantics p : ySemantics p'
      : (genSemantics psi1 ++ genSemantics psi2)        
    where
      ySemantics :: Formula -> Formula
      ySemantics p@(Atom (FormulaLabel (Yesterday psi))) = 
        And (Not p) (Always (Iff (Next p) psi))

      zSemantics :: Formula -> Formula
      zSemantics p@(Atom (FormulaLabel (Wyesterday psi))) = 
        And p (Always (Iff (Next p) psi))

      sSemantics :: Formula -> Formula
      sSemantics p@(Atom (FormulaLabel (Since psi1 psi2))) = 
        Always (Iff p (Or psi2 (And psi1 p')))

      p' = Atom $ FormulaLabel $ Yesterday p
  -- propositional operators
  Not phi                     -> genSemantics phi
  And phi1 phi2               -> genSemantics phi1 ++ genSemantics phi2
  Or phi1 phi2                -> genSemantics phi1 ++ genSemantics phi2
  -- past temporal operators can not happen
  -- future temporal operators
  Next phi                    -> genSemantics phi
  Eventually phi              -> genSemantics phi
  Always phi                  -> genSemantics phi
  Until phi1 phi2             -> genSemantics phi1 ++ genSemantics phi2
  Release phi1 phi2           -> genSemantics phi1 ++ genSemantics phi2

removePast :: Formula -> Formula
removePast = gamma . subPast
  where 
    gamma f = foldl And f (genSemantics f)