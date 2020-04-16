module Data.Msg exposing (..)

import Data.Landscape exposing (House(..))


type Msg
    = Next Int
    | Build House Int Int
