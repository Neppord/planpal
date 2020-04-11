module Main exposing (..)

import Data.Timeline exposing (predict, unwrap)
import Element exposing (..)
import Html exposing (Html)
import Model exposing (Model, init)
import View.Landscape exposing (landscape)
import View.Timeline exposing (timeline)


main =
    view init


view : Model -> Html msg
view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline <| predict 10 model, landscape <| unwrap model ]
