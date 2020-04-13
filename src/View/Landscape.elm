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


house =
    tile green "House"


empty =
    tile grey "Empty"


renderColumn c =
    c
        |> List.map ((Maybe.map <| always house) >> Maybe.withDefault empty)
        |> column
            [ centerX
            , centerY
            , spacing 10
            ]


viewTiles tiles =
    tiles
        |> List.map renderColumn
        |> row
            [ centerX
            , centerY
            , padding 10
            , spacing 10
            ]
