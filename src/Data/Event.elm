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


at : time -> Action time data -> Event time data
at time action =
    Timestamped time action


every : number -> (data -> data) -> Action number data
every time f =
    let
        action now model =
            ( f model
            , empty
                |> queue
                    (every time f
                        |> at (now + time)
                    )
            )
    in
    Action action



-- Events


type alias Events time data =
    Heap (Event time data)


empty : Events comparable data
empty =
    Heap.empty (Heap.smallest |> Heap.by timestamp)


queue : Event time data -> Events time data -> Events time data
queue event events =
    events |> Heap.push event


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
                if nextData == data then
                    predict n nextData nextEvents

                else
                    nextData :: predict (n - 1) nextData nextEvents

            Nothing ->
                []
