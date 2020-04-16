module View.Landscape exposing (..)

import Colors exposing (..)
import Data.Landscape as Landscape exposing (Building(..), Landscape)
import Data.Matrix as Matrix
import Data.Msg exposing (Msg(..))
import Data.SparseMatrix as SparseMatrix
import Data.UI as UI exposing (UI)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import View.Extras exposing (unSelectable)


landscape : UI Landscape -> Element Msg
landscape ui =
    [ case ui of
        UI.Build _ building ->
            buildDrawer building
    , viewTiles ui
    ]
        |> column
            [ width fill
            , height fill
            , Background.color dirtBrown
            ]


buildDrawer building =
    let
        selected =
            el
                [ Border.glow Colors.dirtBrown 5
                , Border.rounded 5
                ]

        selectOn item =
            if building == item then
                selected

            else
                identity
    in
    [ house |> selectOn Landscape.House
    ]
        |> row
            [ width fill
            , Background.color Colors.grey
            , padding 10
            , spacing 10
            ]


tile color title =
    el
        [ Background.color color
        , padding 15
        , height <| px 50
        , width <| px 50
        , clip
        , Border.rounded 5
        , Font.size 14
        , unSelectable
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


empty building x y =
    tile grey "Empty"
        |> el [ onClick <| Build building x y ]


viewTiles : UI Landscape -> Element Msg
viewTiles ui =
    case ui of
        UI.Build tiles building ->
            tiles
                |> SparseMatrix.map (always house)
                |> SparseMatrix.indexedFill (empty building)
                |> Matrix.columns
                |> List.map (column [ centerX, centerY, spacing 10 ])
                |> row [ centerX, centerY, padding 10, spacing 10 ]
