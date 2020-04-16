module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Landscape exposing (Landscape, housingModel)
import Data.Timeline exposing (Timeline, queue, wrap)


type alias Stats =
    Int


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


addToMoney amount =
    mapStats ((+) amount)


init : Model
init =
    wrap
        { landscape = housingModel
        , stats = 0
        }
        |> queue (every 100 (addToMoney 500) |> at 0)
        |> queue (every 300 (addToMoney -300) |> at 300)
