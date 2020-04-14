module Data.SparseMatrix exposing (..)

import Data.Matrix as Matrix exposing (Matrix)


type alias SparseMatrix a =
    Matrix (Maybe a)


fill : a -> SparseMatrix a -> Matrix a
fill a =
    Matrix.map (Maybe.withDefault a)


map : (a -> b) -> SparseMatrix a -> SparseMatrix b
map =
    Matrix.map << Maybe.map
