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


filter : (a -> Bool) -> SparseMatrix a -> SparseMatrix a
filter predicate =
    let
        callback v =
            if predicate v then
                Just v

            else
                Nothing
    in
    Matrix.map <| Maybe.andThen callback


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


compact : List (Maybe a) -> List a
compact =
    List.concatMap
        (\n ->
            case n of
                Nothing ->
                    []

                Just a ->
                    [ a ]
        )


indexedItems : (Int -> Int -> a -> b) -> SparseMatrix a -> List b
indexedItems f m =
    let
        callback x y =
            Maybe.map <| f x y
    in
    m
        |> Matrix.indexedItems callback
        |> compact
