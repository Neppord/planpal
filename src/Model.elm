module Model exposing (..)

import Heap exposing (Heap, by, smallest)
import Maybe as Maybe


type alias Timestamped value =
    { timestamp : Int
    , value : value
    }


type Event
    = Event (Timestamped Model -> Model)


type alias Timeline =
    Heap (Timestamped Event)


pop : Model -> Maybe ( Event, Timestamped Model )
pop model =
    let
        repack ( timestampedEvent, timeline ) =
            ( timestampedEvent.value
            , { timestamp = timestampedEvent.timestamp
              , value = { model | timeline = timeline }
              }
            )
    in
    Maybe.map repack <| Heap.pop model.timeline


apply : Event -> Timestamped Model -> Model
apply (Event f) timestampedModel =
    f timestampedModel


next : Model -> Maybe Model
next model =
    Maybe.map (\( a, b ) -> apply a b) (pop model)


predict : Int -> Model -> List Model
predict n model =
    if n <= 0 then
        []

    else
        case next model of
            Just a ->
                a :: predict (n - 1) a

            Nothing ->
                []


type alias Model =
    { landscape : Landscape
    , timeline : Timeline
    }


type alias Landscape =
    SmallLandscape Int


type alias SmallLandscape a =
    { p00 : a
    , p10 : a
    , p20 : a
    , p01 : a
    , p11 : a
    , p21 : a
    , p02 : a
    , p12 : a
    , p22 : a
    }


housingModel : SmallLandscape Int
housingModel =
    { p00 = 0
    , p10 = 1
    , p20 = 0
    , p01 = 2
    , p11 = 3
    , p21 = 0
    , p02 = 4
    , p12 = 0
    , p22 = 0
    }


toMatrix : Landscape -> List (List Int)
toMatrix m =
    [ [ m.p00, m.p01, m.p02 ]
    , [ m.p10, m.p11, m.p12 ]
    , [ m.p20, m.p21, m.p22 ]
    ]


init : Model
init =
    { landscape = housingModel
    , timeline = Heap.empty (smallest |> by .timestamp)
    }
