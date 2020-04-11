module View.Timeline exposing (..)

import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border


eventAttr color =
    [ padding 10
    , Border.rounded 5
    , Background.color color
    , mouseOver <| [ scale 1.2 ]
    , pointer
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
        |> List.map
            (\n ->
                if n >= 0 then
                    income

                else
                    expense
            )
        |> column
            [ width fill
            , spacing 10
            , height fill
            , Background.color <| grey
            ]
