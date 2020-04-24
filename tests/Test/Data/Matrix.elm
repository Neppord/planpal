module Test.Data.Matrix exposing (..)

import Data.Matrix exposing (columnCount, columns, fromColumns, rowCount)
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
        , test "rowCount" <|
            \() ->
                [ [ 1 ], [ 2 ] ]
                    |> fromColumns
                    |> rowCount
                    |> Expect.equal 1
        ]
