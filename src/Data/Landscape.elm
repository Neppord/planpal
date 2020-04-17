module Data.Landscape exposing (..)

import Data.SparseMatrix exposing (SparseMatrix)


type alias Landscape =
    SparseMatrix Building


type Building
    = House
    | Forest


housingModel : Landscape
housingModel =
    [ [ Nothing, Nothing, Nothing ]
    , [ Nothing, Nothing, Nothing ]
    , [ Nothing, Nothing, Nothing ]
    ]
