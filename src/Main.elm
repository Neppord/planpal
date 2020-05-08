module Main exposing (..)

import Browser
import Colors exposing (grey)
import Data.Game as Game
import Data.Landscape as Landscape
import Data.Matrix as Matrix
import Data.Msg exposing (Msg(..))
import Data.SparseMatrix as SparseMatrix
import Data.Timeline as Timeline exposing (predict, unwrap)
import Data.UI as UI
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Html exposing (Html)
import Model exposing (Model, init)
import View.Landscape exposing (landscapeView)
import View.Timeline exposing (timeline)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


update msg model =
    let
        payFor : Landscape.Building -> Game.Game -> Maybe Game.Game
        payFor building game =
            game
                |> (case building of
                        Landscape.House ->
                            if Game.getWood game >= 10 then
                                Just << Game.mapWood ((+) -10)

                            else
                                always Nothing

                        Landscape.Forest ->
                            if Game.getMoney game >= 10 then
                                Just << Game.mapMoney ((+) -10)

                            else
                                always Nothing
                   )

        payForExpand game =
            game
                |> (if Game.getMoney game >= 100 then
                        Just << Game.mapMoney ((+) -100)

                    else
                        always Nothing
                   )

        place building x y =
            Game.mapLandscape
                (Matrix.update (always <| Just building) x y)
    in
    case msg of
        Next n ->
            model
                |> UI.map
                    (List.repeat (n + 1) Timeline.nextReal
                        |> List.foldl (>>) identity
                    )

        Build building x y ->
            let
                build game =
                    game
                        |> payFor building
                        |> Maybe.map (place building x y)
                        |> Maybe.withDefault game
            in
            model
                |> UI.map (Timeline.map build)

        PickTool building ->
            UI.selectBuildTool building model

        ExpandRight ->
            (UI.map << Timeline.map)
                (\game ->
                    game
                        |> payForExpand
                        |> Maybe.map (Game.mapLandscape SparseMatrix.growRight)
                        |> Maybe.withDefault game
                )
                model

        ExpandLeft ->
            (UI.map << Timeline.map)
                (\game ->
                    game
                        |> payForExpand
                        |> Maybe.map (Game.mapLandscape SparseMatrix.growLeft)
                        |> Maybe.withDefault game
                )
                model


view : Model -> Html Msg
view model =
    layout [ height fill ] <|
        row [ height fill, width fill ]
            [ model
                |> UI.unwrap
                |> leftPanel
            , model
                |> UI.map Timeline.unwrap
                |> UI.map .landscape
                |> landscapeView
            ]


leftPanel model =
    let
        innerModel =
            unwrap model

        predictions =
            predict 10 model

        nextStats =
            predictions
                |> List.head
                |> Maybe.withDefault innerModel
                |> .stats
    in
    [ stats innerModel.stats nextStats
    , timeline innerModel <| predictions
    ]
        |> column
            [ width <| px 200
            , height fill
            , Background.color <| grey
            , padding 15
            , spacing 10
            , scrollbarY
            ]


stat =
    row
        [ width fill
        , Background.color <| rgb 1 1 1
        , padding 10
        , Border.rounded 5
        , spacing 10
        ]


integer =
    String.fromInt >> text


icon color =
    el
        [ Background.color color
        , width <| px 20
        , height <| px 20
        , Border.rounded 5
        ]
        none


value =
    el [ width fill, Font.alignRight ]


stats : Game.Stats -> Game.Stats -> Element msg
stats s next =
    let
        moneyDiff =
            next.money - s.money

        woodDiff =
            next.wood - s.wood

        diff : Int -> Element msg
        diff amount =
            case compare amount 0 of
                LT ->
                    integer amount
                        |> el [ Font.color Colors.red ]

                EQ ->
                    none

                GT ->
                    String.fromInt amount
                        |> (++) "+"
                        |> text
                        |> el
                            [ Font.color Colors.green
                            , width shrink
                            ]
    in
    [ [ text "$", value <| integer s.money, diff moneyDiff ]
    , [ icon Colors.dirtBrown, value <| integer s.wood, diff woodDiff ]
    , [ icon Colors.blue, value <| integer s.water ]
    ]
        |> List.map stat
        |> column
            [ width fill
            , spacing 10
            , Font.family
                [ Font.external
                    { url = "https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap"
                    , name = "Kaushan Script"
                    }
                ]
            ]
