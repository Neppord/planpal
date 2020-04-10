module Main exposing (..)

import Element exposing (..)
import Landscape exposing (landscape)
import Timeline exposing (timeline)


main =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline, landscape ]
