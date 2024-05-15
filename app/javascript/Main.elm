--
-- $Id$
--


module Main exposing (..)

import Browser
import ChessBoard exposing (ChessBoard)
import Html exposing (Html, table, td, tr)
import Html.Attributes exposing (height, style, width)
import Square exposing (Square, file, rank)
import SquareFile
import SquareRank


type alias Model = ChessBoard


type Message
    = Render


init : String -> ( Model, Cmd Message )
init data =
    ( ChessBoard.start, Cmd.none )


view : Model -> Html Message
view model =
    let
        -- reverse the chessboard rows are we display row 8 at the top
        rows = model.squares
            |> List.reverse
            |> List.map squaresToTableRow
    in
        table [] rows

squaresToTableRow: List Square -> Html msg
squaresToTableRow square_list =
    let
        tds = square_list |> List.map squareToTableCell
    in
        tr [] tds

square_height = height 45
square_width = width 45
odd_files = [SquareFile.a, SquareFile.c, SquareFile.e, SquareFile.g]
odd_ranks = [SquareRank.one, SquareRank.three, SquareRank.five, SquareRank.seven]

squareToTableCell: Square -> Html msg
squareToTableCell square =
    let
        sq_file = square |> file
        sq_row = square |> rank

        odd_file = odd_files |> List.any (\a_file -> sq_file == a_file)
        odd_row = odd_ranks |> List.any (\a_row -> sq_row == a_row)
        color = if (odd_file && not odd_row) || (not odd_file && odd_row)
                then
                    "#ffce9e"
                else
                    "#d18b47"
        bg = style "background-color" color
    in
        td [square_height, square_width, bg] []


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
