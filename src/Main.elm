module Main exposing (..)

import Browser
import Colors exposing (grey)
import Data.Game as Game
import Data.Matrix as Matrix
import Data.Msg exposing (Msg(..))
import Data.Timeline as Timeline exposing (predict, unwrap)
import Data.UI as UI
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Model exposing (Model, init)
import View.Landscape exposing (landscape)
import View.Timeline exposing (timeline)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


update msg model =
    case msg of
        Next n ->
            model
                |> UI.map
                    (List.repeat (n + 1) Timeline.next
                        |> List.foldl (>>) identity
                    )

        Build building x y ->
            model
                |> UI.map
                    ((Timeline.map << Game.mapLandscape)
                        (Matrix.update (always <| Just building) x y)
                    )


view : Model -> Html Msg
view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ model
                |> UI.unwrap
                |> leftPanel
            , model
                |> UI.map Timeline.unwrap
                |> UI.map .landscape
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
            , scrollbarY
            ]


stats s =
    [ text "$"
    , String.fromInt s.money
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
