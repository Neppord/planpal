module View.Timeline exposing (..)

import Colors exposing (..)
import Data.Msg exposing (Msg(..))
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Html.Attributes


eventAttr color =
    [ padding 10
    , Border.rounded 5
    , Background.color color
    , mouseOver <| [ scale 1.2 ]
    , pointer
    , Html.Attributes.style "user-select" "none"
        |> htmlAttribute
    ]


income =
    el
        (eventAttr green)
    <|
        text "Income"


expense =
    el
        (eventAttr red)
    <|
        text "Expense"


timeline current states =
    let
        futureStats =
            List.map .stats states

        stats =
            current.stats :: futureStats

        diffs =
            List.map2 (-) futureStats stats
    in
    diffs
        |> List.indexedMap
            (\i n ->
                let
                    clickWrapper =
                        el [ Next i |> onClick ]
                in
                if n >= 0 then
                    income |> clickWrapper

                else
                    expense |> clickWrapper
            )
        |> column
            [ width fill
            , spacing 10
            , height fill
            , Background.color <| grey
            ]
