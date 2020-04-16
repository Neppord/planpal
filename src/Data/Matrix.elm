module Data.Matrix exposing (..)


type alias Matrix x =
    List (List x)


map : (a -> b) -> Matrix a -> Matrix b
map =
    List.map << List.map


indexedMap : (Int -> Int -> a -> b) -> Matrix a -> Matrix b
indexedMap f =
    let
        callback x column =
            List.indexedMap (\y tile -> f x y tile) column
    in
    List.indexedMap callback


update : (a -> a) -> Int -> Int -> Matrix a -> Matrix a
update f px py =
    let
        callback x y =
            if px == x && py == y then
                f

            else
                identity
    in
    indexedMap callback


items : Matrix a -> List a
items =
    List.concat


indexedItems : (Int -> Int -> a -> b) -> Matrix a -> List b
indexedItems f =
    indexedMap f >> items


columns : Matrix a -> List (List a)
columns =
    identity
