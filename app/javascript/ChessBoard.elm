module ChessBoard exposing (..)

import Square exposing (Square)
import SquareFile
import SquareRank exposing (SquareRank)


type alias ChessBoard =
    {
        squares : List (List Square)
    }


start : ChessBoard
start =
    ChessBoard (SquareRank.all |> List.map makeRow)


makeRow : SquareRank -> List Square
makeRow rank =
    SquareFile.all |> List.map (\col -> Square.make col rank)
