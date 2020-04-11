module Data.Timestamped exposing (..)


type Timestamped time data
    = Timestamped time data


map f (Timestamped time data) =
    Timestamped time <| f data


timestamp (Timestamped time _) =
    time
