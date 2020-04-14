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


rows : Matrix a -> List (List a)
rows matrix =
    let
        flip : List (Maybe a) -> Maybe (List a)
        flip =
            List.foldr (Maybe.map2 (::)) (Just [])

        -- this should not be needed
        flipTyped : List (Maybe (List a)) -> Maybe (List (List a))
        flipTyped =
            List.foldr (Maybe.map2 (::)) (Just [])

        head : Matrix a -> Maybe (List a)
        head m =
            m
                |> List.map List.head
                |> flip

        tail : List (List a) -> Maybe (List (List a))
        tail m =
            m
                |> List.map List.tail
                |> flipTyped
    in
    case ( head matrix, tail matrix ) of
        ( Nothing, _ ) ->
            []

        ( Just row, Nothing ) ->
            row :: []

        ( Just row, Just m ) ->
            row :: rows m
