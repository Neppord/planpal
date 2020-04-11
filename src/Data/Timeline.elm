module Data.Timeline exposing (..)

import Data.Event as Event exposing (Events)


type Timeline time data
    = Timeline (Events time data) data


wrap data =
    Timeline Event.empty data


unwrap (Timeline _ data) =
    data


map f (Timeline events data) =
    Timeline events <| f data


predict : Int -> Timeline time data -> List data
predict n (Timeline events data) =
    Event.predict n data events
