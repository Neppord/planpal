module Model exposing (..)

import Heap exposing (Heap, by, smallest)


type alias Timestamped value =
    { timestamp : Int
    , value : value
    }


type Event
    = Event


type alias Model =
    { landscape : SmallMap Int
    , timeline : Heap (Timestamped Event)
    }


type alias SmallMap a =
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


housingModel : SmallMap Int
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
