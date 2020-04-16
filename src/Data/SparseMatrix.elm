module Data.SparseMatrix exposing (..)

import Data.Matrix as Matrix exposing (Matrix)


type alias SparseMatrix a =
    Matrix (Maybe a)


fill : a -> SparseMatrix a -> Matrix a
fill a =
    Matrix.map (Maybe.withDefault a)


indexedFill : (Int -> Int -> a) -> SparseMatrix a -> Matrix a
indexedFill f =
    let
        callback x y =
            Maybe.withDefault (f x y)
    in
    Matrix.indexedMap callback


map : (a -> b) -> SparseMatrix a -> SparseMatrix b
map =
    Matrix.map << Maybe.map


items : SparseMatrix a -> List a
items m =
    m
        |> Matrix.items
        |> List.concatMap
            (\n ->
                case n of
                    Nothing ->
                        []

                    Just a ->
                        [ a ]
            )
