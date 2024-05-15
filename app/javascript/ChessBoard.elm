module ChessBoard exposing (..)

import Position exposing (Position)
import Square exposing (Square)
import SquareFile
import SquareRank exposing (SquareRank)


type alias ChessBoard =
    { position : Position
    }


start : ChessBoard
start =
    ChessBoard Position.initial


makeRow : SquareRank -> List Square
makeRow rank =
    SquareFile.all |> List.map (\col -> Square.make col rank)
