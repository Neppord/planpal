module Data.UI exposing (..)

import Data.Landscape as Landscape


type UI a
    = Build a Landscape.Building


map : (a -> b) -> UI a -> UI b
map f ui =
    case ui of
        Build a building ->
            Build (f a) building


wrap : a -> UI a
wrap a =
    Build a Landscape.House


unwrap : UI a -> a
unwrap ui =
    case ui of
        Build a _ ->
            a


selectBuildTool : Landscape.Building -> UI a -> UI a
selectBuildTool building ui =
    case ui of
        Build a _ ->
            Build a building
