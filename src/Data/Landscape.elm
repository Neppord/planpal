module Data.Landscape exposing (..)

import Data.SparseMatrix exposing (SparseMatrix)


type alias Landscape =
    SparseMatrix House


type House
    = House


housingModel : Landscape
housingModel =
    [ [ Nothing, Just House, Nothing ]
    , [ Just House, Just House, Nothing ]
    , [ Just House, Nothing, Nothing ]
    ]
