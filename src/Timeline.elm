module Timeline exposing (..)

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


timeline =
    column
        [ width <| px 150
        , padding 15
        , spacing 10
        , height fill
        , Background.color <| timelineColor
        ]
        [ income
        , income
        , income
        , income
        , income
        , expense
        , income
        , income
        , income
        , expense
        ]
