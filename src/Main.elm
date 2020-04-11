module Main exposing (..)

import Browser
import Colors exposing (grey)
import Data.Msg exposing (Msg(..))
import Data.Timeline as Timeline exposing (predict, unwrap)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Model exposing (Model, init)
import View.Landscape exposing (landscape)
import View.Timeline exposing (timeline)


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


update msg model =
    case msg of
        Next n ->
            (List.repeat (n + 1) Timeline.next
                |> List.foldl (>>) identity
            )
                model


view : Model -> Html Msg
view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ leftPanel model
            , unwrap model
                |> .landscape
                |> landscape
            ]


leftPanel model =
    let
        innerModel =
            unwrap model
    in
    [ stats innerModel.stats
    , timeline innerModel <| predict 10 model
    ]
        |> column
            [ width <| px 150
            , height fill
            , Background.color <| grey
            , padding 15
            , spacing 10
            ]


stats s =
    [ text "$"
    , String.fromInt s
        |> text
        |> el [ alignRight ]
    ]
        |> row
            [ width fill
            , Background.color <| rgb 1 1 1
            , padding 10
            , Border.rounded 5
            , Font.family
                [ Font.external
                    { url = "https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap"
                    , name = "Kaushan Script"
                    }
                ]
            ]
