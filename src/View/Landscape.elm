module View.Landscape exposing (..)

import Colors exposing (..)
import Data.Landscape exposing (Landscape)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border


landscape : Landscape -> Element msg
landscape l =
    el
        [ width fill
        , height fill
        , Background.color dirtBrown
        ]
    <|
        viewTiles l


viewTiles tiles =
    let
        house =
            tile green "House"

        empty =
            tile grey "Empty"

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

        numberToTile n =
            case n of
                Just _ ->
                    house

                Nothing ->
                    empty

        renderColumn c =
            column
                [ centerX
                , centerY
                , spacing 10
                ]
            <|
                List.map numberToTile c
    in
    row
        [ centerX
        , centerY
        , padding 10
        , spacing 10
        ]
    <|
        List.map renderColumn tiles
