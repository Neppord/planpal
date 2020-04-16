module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Landscape exposing (Building(..), Landscape, housingModel)
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
            model.landscape
                |> SparseMatrix.filter ((==) House)
                |> SparseMatrix.indexedItems (\x y _ -> ( x, y ))
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
                |> Set.toList
                |> List.map bonus
                |> List.map ((+) 10)
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
        |> queue (houseIncome |> every 100 |> at 0)
        |> queue (addToMoney -300 |> every 300 |> at 300)
