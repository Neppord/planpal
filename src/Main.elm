module Main exposing (..)

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


red =
    rgb 0.8 0.5 0.5


green =
    rgb 0.5 0.9 0.5


timelineColor =
    rgb 0.9 0.9 0.92


dirtBrown =
    rgb 0.6 0.5 0.3


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


landscape =
    el
        [ width fill
        , height fill
        , Background.color dirtBrown
        ]
    <|
        none


main =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline, landscape ]
