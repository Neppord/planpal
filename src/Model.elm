module Model exposing (..)

import Data.Event exposing (at, every)
import Data.Game as Game exposing (Game, addToMoney, forestIncome, houseIncome)
import Data.Timeline as Timeline exposing (Timeline)
import Data.UI as UI exposing (UI)


type alias Model =
    UI (Timeline Int Game)


init : Model
init =
    Game.init
        |> Timeline.wrap
        |> Timeline.queue (houseIncome >> forestIncome |> every 100 |> at 0)
        |> Timeline.queue (addToMoney -1000 |> every 300 |> at 900)
        |> UI.wrap
