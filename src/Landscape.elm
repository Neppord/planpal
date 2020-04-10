module Landscape exposing (..)

import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Model exposing (housingModel, toMatrix)


landscape _ =
    el
        [ width fill
        , height fill
        , Background.color dirtBrown
        ]
    <|
        tiles


tiles =
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

        numberToTile n =
            if n > 0 then
                house

            else
                empty

        houseMatrix =
            toMatrix housingModel

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
        List.map renderColumn houseMatrix
