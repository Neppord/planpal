module View.Landscape exposing (..)

import Colors exposing (..)
import Data.Landscape as House exposing (Building(..), Landscape)
import Data.Matrix as Matrix
import Data.Msg exposing (Msg(..))
import Data.SparseMatrix as SparseMatrix
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)


landscape : Landscape -> Element Msg
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


empty x y =
    tile grey "Empty"
        |> el [ onClick <| Build House.House x y ]


viewTiles : SparseMatrix.SparseMatrix b -> Element Msg
viewTiles tiles =
    tiles
        |> SparseMatrix.map (always house)
        |> SparseMatrix.indexedFill empty
        |> Matrix.columns
        |> List.map (column [ centerX, centerY, spacing 10 ])
        |> row [ centerX, centerY, padding 10, spacing 10 ]
