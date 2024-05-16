--
-- $Id$
--


module Main exposing (..)

import Browser
import ChessBoard exposing (ChessBoard, allSquares, makeRow)
import Html exposing (Html, img, table, td, tr)
import Html.Attributes exposing (height, src, style, width)
import Piece exposing (Piece, color, kind)
import PieceColor
import PieceType exposing (toString)
import Position exposing (Position, pieceOn)
import Square exposing (Square, file, rank)
import SquareFile
import SquareRank
import String exposing (toLower)


type alias Model =
    ChessBoard


type Message
    = Render


init : String -> ( Model, Cmd Message )
init data =
    ( ChessBoard.start, Cmd.none )


odd_files =
    [ SquareFile.a, SquareFile.c, SquareFile.e, SquareFile.g ]


odd_ranks =
    [ SquareRank.one, SquareRank.three, SquareRank.five, SquareRank.seven ]


square_height =
    height 45


square_width =
    width 45


view : Model -> Html Message
view model =
    let
        -- reverse the chessboard rows are we display row 8 at the top
        rows =
            allSquares
                |> List.reverse
                |> List.map (squaresToTableRow model.position)
    in
    table [] rows


squaresToTableRow : Position -> List Square -> Html msg
squaresToTableRow position square_list =
    let
        tds =
            square_list |> List.map (squareToTableCell position)
    in
    tr [] tds


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


squareToTableCell : Position -> Square -> Html msg
squareToTableCell position square =
    let
        sq_file =
            square |> file

        sq_row =
            square |> rank

        odd_file =
            odd_files |> List.any (\a_file -> sq_file == a_file)

        odd_row =
            odd_ranks |> List.any (\a_row -> sq_row == a_row)

        color =
            if (odd_file && not odd_row) || (not odd_file && odd_row) then
                "#ffce9e"

            else
                "#d18b47"

        bg =
            style "background-color" color

        glyph =
            case position |> pieceOn square of
                Just piece ->
                    let
                        source =
                            "/pieces/Chess_" ++ (piece |> piece_glyph) ++ "45.svg"

                        tag =
                            img [ src source ] []
                    in
                    [ tag ]

                Nothing ->
                    []
    in
    td [ square_height, square_width, bg ] glyph


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


main : Program String Model Message
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
