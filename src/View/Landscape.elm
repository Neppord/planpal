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
    [ case UI.selectedTool ui of
        UI.Build building ->
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

        select item =
            el [ onClick <| PickTool item ]

        selectOn item =
            if building == item then
                selected

            else
                select item
    in
    [ house |> selectOn Landscape.House
    , forest |> selectOn Landscape.Forest
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


forest =
    tile darkGreen "Forest"


empty building x y =
    tile grey "Empty"
        |> el [ onClick <| Build building x y ]


buildingToTile n =
    case n of
        House ->
            house

        Forest ->
            forest


viewTiles : UI Landscape -> Element Msg
viewTiles ui =
    case UI.selectedTool ui of
        UI.Build building ->
            ui
                |> UI.unwrap
                |> SparseMatrix.map buildingToTile
                |> SparseMatrix.indexedFill (empty building)
                |> Matrix.columns
                |> List.map (column [ centerX, centerY, spacing 10 ])
                |> row [ centerX, centerY, padding 10, spacing 10 ]
