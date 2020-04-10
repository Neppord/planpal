module Main exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Landscape exposing (landscape)
import Model
import Timeline exposing (timeline)


main =
    view Model.init


view : Model.Model -> Html msg
view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline model.timeline, landscape model.landscape ]
