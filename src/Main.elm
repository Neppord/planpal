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
    let
        innerModel =
            unwrap model
    in
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline innerModel <| predict 10 model, landscape <| innerModel.landscape ]
