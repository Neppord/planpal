module Data.Timeline exposing (..)

import Data.Event as Event exposing (Event, Events)


type Timeline time data
    = Timeline (Events time data) data


wrap data =
    Timeline Event.empty data


unwrap (Timeline _ data) =
    data


queue : Event time data -> Timeline time data -> Timeline time data
queue event (Timeline events data) =
    Timeline (events |> Event.queue event) data


map f (Timeline events data) =
    Timeline events <| f data


next : Timeline time data -> Timeline time data
next (Timeline events data) =
    case Event.next data events of
        Just ( nextData, nextEvents ) ->
            Timeline nextEvents nextData

        Nothing ->
            Timeline events data


nextReal : Timeline time data -> Timeline time data
nextReal (Timeline currentEvents currentData) =
    case next (Timeline currentEvents currentData) of
        Timeline events data ->
            if data == currentData then
                nextReal (Timeline events data)

            else
                Timeline events data


predict : Int -> Timeline time data -> List data
predict n (Timeline events data) =
    Event.predict n data events
