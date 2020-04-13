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
