module Chess exposing (..)

import Json.Decode exposing (Decoder, andThen)
import Json.Decode.Pipeline exposing (required)
import Piece exposing (Piece, color, kind)
import PieceColor
import PieceType exposing (toString)
import Position exposing (Position)
import Square exposing (Square, file, rank)
import SquareFile
import SquareRank exposing (SquareRank)
import String exposing (toLower)


type alias ChessBoard =
    { position : Position
    }


type alias ChessMove =
    { number : Int
    , from : Square
    , to : Square
    , move : String
    }


squareFromString : String -> Decoder Square
squareFromString raw_square =
    let
        maybe_square =
            raw_square |> Square.fromString
    in
    case maybe_square of
        Just square ->
            Json.Decode.succeed square

        Nothing ->
            Json.Decode.fail ("Invalid square " ++ raw_square)


squareDecoder : Decoder Square
squareDecoder =
    Json.Decode.string |> andThen squareFromString


chessMoveDecoder : Decoder ChessMove
chessMoveDecoder =
    Json.Decode.succeed ChessMove
        |> required "number" Json.Decode.int
        |> required "from" squareDecoder
        |> required "to" squareDecoder
        |> required "move" Json.Decode.string


moveListDecoder : Decoder (List ChessMove)
moveListDecoder =
    Json.Decode.list chessMoveDecoder


odd_files =
    [ SquareFile.a, SquareFile.c, SquareFile.e, SquareFile.g ]


odd_ranks =
    [ SquareRank.one, SquareRank.three, SquareRank.five, SquareRank.seven ]


start : ChessBoard
start =
    ChessBoard Position.initial



--allSquares: List (List Square)
-- all the squares on the chess board - its a constant


allSquares =
    SquareRank.all |> List.map makeRow


makeRow : SquareRank -> List Square
makeRow rank =
    SquareFile.all |> List.map (\col -> Square.make col rank)


isOddFile : Square -> Bool
isOddFile square =
    let
        sq_file =
            square |> file
    in
    odd_files |> List.any (\a_file -> sq_file == a_file)


isOddRow : Square -> Bool
isOddRow square =
    let
        sq_row =
            square |> rank
    in
    odd_ranks |> List.any (\a_row -> sq_row == a_row)


squareColour : Square -> String
squareColour square =
    let
        odd_file =
            square |> isOddFile

        odd_row =
            square |> isOddRow
    in
    if (odd_file && not odd_row) || (not odd_file && odd_row) then
        "light-square"

    else
        "dark-square"


piece_glyph : Piece -> String
piece_glyph piece =
    let
        second =
            if (piece |> color) == PieceColor.white then
                "l"

            else
                "d"
    in
    (piece |> kind |> toString |> toLower) ++ second ++ "t"
