module Model exposing (..)

import Data.Landscape exposing (Landscape, housingModel)
import Data.Timeline exposing (Timeline, wrap)


type alias Model =
    Timeline Int Landscape


init : Model
init =
    wrap housingModel
