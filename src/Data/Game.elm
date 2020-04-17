module Data.Game exposing (..)

import Data.Landscape exposing (Building(..), Landscape, housingModel)
import Data.SparseMatrix as SparseMatrix
import Set


init : Game
init =
    { landscape = housingModel
    , stats =
        { money = 0
        , wood = 0
        }
    }


type alias Money =
    Int


type alias Wood =
    Int


type alias Stats =
    { money : Money
    , wood : Wood
    }


type alias Game =
    { landscape : Landscape
    , stats : Stats
    }


mapLandscape f model =
    { model | landscape = f model.landscape }


mapMoney : (Money -> Money) -> Game -> Game
mapMoney =
    let
        callback f s =
            { s | money = f s.money }
    in
    mapStats << callback


mapStats : (Stats -> Stats) -> Game -> Game
mapStats f model =
    { model | stats = f model.stats }


addToMoney : Money -> Game -> Game
addToMoney amount =
    mapMoney ((+) amount)


houseIncome : Game -> Game
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
    mapMoney ((+) income) model
