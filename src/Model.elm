module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Game exposing (Game, addToMoney, houseIncome)
import Data.Landscape exposing (Building(..), Landscape, housingModel)
import Data.Timeline as Timeline exposing (Timeline)
import Data.UI as UI exposing (UI)


type alias Model =
    UI (Timeline Int Game)


init : Model
init =
    { landscape = housingModel
    , stats = { money = 0 }
    }
        |> Timeline.wrap
        |> Timeline.queue (houseIncome |> every 100 |> at 0)
        |> Timeline.queue (addToMoney -300 |> every 300 |> at 300)
        |> UI.wrap
