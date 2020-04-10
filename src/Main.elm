module Main exposing (..)

import Element exposing (..)
import Landscape exposing (landscape)
import Model
import Timeline exposing (timeline)


main =
    view Model.init


view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline, landscape ]
