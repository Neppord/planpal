module Data.UI exposing (..)

import Data.Landscape as Landscape


type UI a
    = UI a Selection Info


type Selection
    = Build Landscape.Building


type Info
    = NoInfo


map : (a -> b) -> UI a -> UI b
map f ui =
    case ui of
        UI a selection info ->
            UI (f a) selection info


wrap : a -> UI a
wrap a =
    UI a (Build Landscape.House) NoInfo


unwrap : UI a -> a
unwrap ui =
    case ui of
        UI a _ _ ->
            a


selectedTool (UI _ tool _) =
    tool


selectBuildTool : Landscape.Building -> UI a -> UI a
selectBuildTool building ui =
    case ui of
        UI a _ info ->
            UI a (Build building) info
