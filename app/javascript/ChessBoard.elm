module ChessBoard exposing (..)

import Position exposing (Position)
import Square exposing (Square)
import SquareFile
import SquareRank exposing (SquareRank)


type alias ChessBoard =
    { squares : List (List Square),
    position: Position
    }


start : ChessBoard
start =
    ChessBoard (SquareRank.all |> List.map makeRow) Position.initial


makeRow : SquareRank -> List Square
makeRow rank =
    SquareFile.all |> List.map (\col -> Square.make col rank)
