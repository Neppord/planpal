module Data.Landscape exposing (..)


type alias Landscape =
    List (List (Maybe House))


type House
    = House


housingModel : Landscape
housingModel =
    [ [ Nothing, Just House, Nothing ]
    , [ Just House, Just House, Nothing ]
    , [ Just House, Nothing, Nothing ]
    ]


toInt : Maybe House -> Int
toInt =
    Maybe.withDefault 0 << Maybe.map (always 1)


toMatrix : Landscape -> List (List Int)
toMatrix =
    List.map <| List.map toInt
