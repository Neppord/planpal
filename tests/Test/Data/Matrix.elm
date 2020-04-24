module Test.Data.Matrix exposing (..)

import Data.Matrix exposing (columnCount, columns, fromColumns)
import Expect
import Test exposing (Test, describe, test)


suit : Test
suit =
    describe "Matrix"
        [ test "columns" <|
            \() ->
                [ [ 1 ], [ 2 ] ]
                    |> fromColumns
                    |> columns
                    |> Expect.equal [ [ 1 ], [ 2 ] ]
        , test "columnCount" <|
            \() ->
                [ [ 1 ], [ 2 ] ]
                    |> fromColumns
                    |> columnCount
                    |> Expect.equal 2
        ]
