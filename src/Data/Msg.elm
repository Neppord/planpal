module Data.Msg exposing (..)

import Data.Landscape exposing (Building(..))


type Msg
    = Next Int
    | Build Building Int Int
    | PickTool Building
