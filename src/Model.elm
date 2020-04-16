module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Landscape exposing (Landscape, housingModel)
import Data.SparseMatrix as SparseMatrix
import Data.Timeline exposing (Timeline, queue, wrap)
import Set


type alias Money =
    Int


type alias Stats =
    Money


type alias InnerModel =
    { landscape : Landscape
    , stats : Stats
    }


type alias Model =
    Timeline Int InnerModel


mapLandscape f model =
    { model | landscape = f model.landscape }


mapStats f model =
    { model | stats = f model.stats }


addToMoney : Money -> InnerModel -> InnerModel
addToMoney amount =
    mapStats ((+) amount)


houseIncome : InnerModel -> InnerModel
houseIncome model =
    let
        housesCoordinates =
            SparseMatrix.indexedItems (\x y _ -> ( x, y )) model.landscape
                |> Set.fromList

        bonus : ( Int, Int ) -> Money
        bonus ( x, y ) =
            let
                check p =
                    Set.member p housesCoordinates
            in
            [ check ( x - 1, y )
            , check ( x + 1, y )
            , check ( x, y - 1 )
            , check ( x, y + 1 )
            ]
                |> List.filter identity
                |> List.map (always 5)
                |> List.sum

        income =
            housesCoordinates
                |> Set.map bonus
                |> Set.map ((+) 10)
                |> Set.toList
                |> List.sum
    in
    model
        |> mapStats ((+) income)


init : Model
init =
    wrap
        { landscape = housingModel
        , stats = 0
        }
        |> queue (every 100 houseIncome |> at 0)
        |> queue (every 300 (addToMoney -300) |> at 300)
