module View.Timeline exposing (..)

import Colors exposing (..)
import Data.Msg exposing (Msg(..))
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import View.Extras exposing (unSelectable)


eventAttr color =
    [ padding 10
    , Border.rounded 5
    , Background.color color
    , mouseOver <| [ scale 1.2 ]
    , pointer
    , unSelectable
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
        futureMoney =
            List.map (.stats >> .money) states

        stats =
            current.stats.money :: futureMoney

        diffs =
            List.map2 (-) futureMoney stats
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
