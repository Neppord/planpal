module Data.Landscape exposing (..)

import Data.SparseMatrix exposing (SparseMatrix)


type alias Landscape =
    SparseMatrix Building


type Building
    = House


housingModel : Landscape
housingModel =
    [ [ Nothing, Nothing, Nothing ]
    , [ Nothing, Nothing, Nothing ]
    , [ Nothing, Nothing, Nothing ]
    ]
