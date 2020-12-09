module Formula.Skel where

-- Haskell module generated by the BNF converter

import Formula.Abs
import Formula.ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transPIdent :: PIdent -> Result
transPIdent x = case x of
  PIdent string -> failure x
transFormula :: Formula -> Result
transFormula x = case x of
  Implies formula1 formula2 -> failure x
  Implied formula1 formula2 -> failure x
  Iff formula1 formula2 -> failure x
  Until formula1 formula2 -> failure x
  Release formula1 formula2 -> failure x
  Since formula1 formula2 -> failure x
  Triggered formula1 formula2 -> failure x
  And formula1 formula2 -> failure x
  Or formula1 formula2 -> failure x
  Next formula -> failure x
  Eventually formula -> failure x
  Always formula -> failure x
  Yesterday formula -> failure x
  Wyesterday formula -> failure x
  Once formula -> failure x
  Historically formula -> failure x
  Not formula -> failure x
  Atom pident -> failure x
  Bool boolean -> failure x
transBoolean :: Boolean -> Result
transBoolean x = case x of
  Boolean_True -> failure x
  Boolean_False -> failure x

