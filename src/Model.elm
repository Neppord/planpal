module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Game exposing (Game, addToMoney, houseIncome)
import Data.Landscape exposing (Building(..), Landscape, housingModel)
import Data.Timeline exposing (Timeline, queue, wrap)


type alias Model =
    Timeline Int Game


init : Model
init =
    wrap
        { landscape = housingModel
        , stats = 0
        }
        |> queue (houseIncome |> every 100 |> at 0)
        |> queue (addToMoney -300 |> every 300 |> at 300)
