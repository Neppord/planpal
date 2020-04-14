module View.Landscape exposing (..)

import Colors exposing (..)
import Data.Landscape exposing (Landscape)
import Data.Matrix as Matrix
import Data.SparseMatrix as SparceMaterix
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


viewTiles : SparceMaterix.SparseMatrix b -> Element msg
viewTiles tiles =
    tiles
        |> SparceMaterix.map (always house)
        |> SparceMaterix.fill empty
        |> Matrix.columns
        |> List.map (column [ centerX, centerY, spacing 10 ])
        |> row [ centerX, centerY, padding 10, spacing 10 ]
