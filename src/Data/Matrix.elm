module Data.Matrix exposing (..)


type alias Matrix x =
    List (List x)


map : (a -> b) -> Matrix a -> Matrix b
map =
    List.map << List.map


toList : Matrix a -> List a
toList =
    List.concat


columns : Matrix a -> List (List a)
columns =
    identity
