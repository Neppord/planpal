module Data.Event exposing (..)

import Data.Timestamped exposing (Timestamped(..), timestamp)
import Heap exposing (Heap, Options)


type Action time data
    = Action (time -> data -> ( data, Events time data ))


type alias Event time data =
    Timestamped time (Action time data)


load : Event time data -> data -> ( data, Events time data )
load (Timestamped time (Action action)) =
    action time



-- Events


type alias Events time data =
    Heap (Event time data)


empty : Events comparable data
empty =
    Heap.empty (Heap.smallest |> Heap.by timestamp)


pop : Events time data -> Maybe ( Event time data, Events time data )
pop events =
    Heap.pop events


popAction : Events time data -> Maybe ( data -> ( data, Events time data ), Events time data )
popAction events =
    pop events
        |> (Maybe.map << Tuple.mapFirst) load


next : data -> Events time data -> Maybe ( data, Events time data )
next data events =
    popAction events
        |> Maybe.map
            (\( action, oldEvents ) ->
                case action data of
                    ( finalData, newEvents ) ->
                        ( finalData, Heap.mergeInto newEvents oldEvents )
            )


predict : Int -> data -> Events time data -> List data
predict n data events =
    if n <= 0 then
        []

    else
        case next data events of
            Just ( nextData, nextEvents ) ->
                nextData :: predict (n - 1) nextData nextEvents

            Nothing ->
                []
