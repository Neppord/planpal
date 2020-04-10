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
        houses


houses =
    let
        house =
            tile green "House"

        empty =
            tile timelineColor "Empty"

        tile color title =
            el
                [ Background.color color
                , padding 15
                , height <| px 75
                , width <| px 75
                , clip
                , Border.rounded 5
                ]
            <|
                el
                    [ centerX
                    , centerY
                    ]
                <|
                    text title
    in
    row
        [ centerX
        , centerY
        , padding 10
        , spacing 10
        ]
    <|
        List.map
            (\c ->
                column
                    [ centerX
                    , centerY
                    , spacing 10
                    ]
                <|
                    List.map
                        (\n ->
                            if n > 0 then
                                house

                            else
                                empty
                        )
                        c
            )
        <|
            toMatrix housingModel


type alias SmallMap a =
    { p00 : a
    , p10 : a
    , p20 : a
    , p01 : a
    , p11 : a
    , p21 : a
    , p02 : a
    , p12 : a
    , p22 : a
    }


housingModel : SmallMap Int
housingModel =
    { p00 = 0
    , p10 = 1
    , p20 = 0
    , p01 = 2
    , p11 = 3
    , p21 = 0
    , p02 = 4
    , p12 = 0
    , p22 = 0
    }


toMatrix m =
    [ [ m.p00, m.p01, m.p02 ]
    , [ m.p10, m.p11, m.p12 ]
    , [ m.p20, m.p21, m.p22 ]
    ]


main =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ timeline, landscape ]
