module View.Extras exposing (..)

import Element exposing (htmlAttribute)
import Html.Attributes


unSelectable =
    Html.Attributes.style "user-select" "none"
        |> htmlAttribute
