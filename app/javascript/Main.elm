--
-- $Id$
--


module Main exposing (..)

import Browser
import Chess exposing (ChessBoard, ChessMove, allSquares, moveListDecoder, piece_glyph, squareColour)
import Html exposing (Html, div, img, table, td, text, th, tr)
import Html.Attributes exposing (class, height, src, width)
import Http exposing (Error, Response)
import Maybe exposing (withDefault)
import Position exposing (Position, pieceOn)
import Square exposing (Square)
import String exposing (fromInt)


type alias Model =
    { board : ChessBoard
    , moves : Maybe (List ChessMove)
    }


type Message
    = MovesLoaded (Result Http.Error (List ChessMove))


init : String -> ( Model, Cmd Message )
init moves_url =
    ( Model Chess.start Nothing, loadMoves moves_url )


square_height =
    height 45


square_width =
    width 45


loadMoves : String -> Cmd Message
loadMoves moves_url =
    Http.get
        { url = moves_url
        , expect = Http.expectJson MovesLoaded moveListDecoder
        }


view : Model -> Html Message
view model =
    let
        -- reverse the chessboard rows are we display row 8 at the top
        rows =
            allSquares
                |> List.reverse
                |> List.map (squaresToTableRow model.board.position)

        board_table =
            table [] rows

        move_table =
            case model.moves of
                Just moves ->
                    let
                        ( whiteblack, spare ) =
                            moves |> List.foldl fold_moves ( [], Nothing )

                        wb_rows =
                            whiteblack |> List.map white_black_to_row

                        move_rows =
                            List.append wb_rows [ spare_to_move_row spare ]

                        head =
                            tr [] [ th [] [], th [] [ text "White" ], th [] [ text "Black" ] ]
                    in
                    table [ class "table table-striped table-sm table-responsive" ] (head :: move_rows)

                Nothing ->
                    table [] []

        heading =
            text ("Elm Chessboard " ++ (model.moves |> withDefault [] |> List.length |> fromInt) ++ " Moves")

        board_div =
            div [ class "col-8" ] [ heading, board_table ]

        moves_div =
            div [ class "col-4" ] [ move_table ]
    in
    div [ class "row" ] [ board_div, moves_div ]


spare_to_move_row : Maybe ChessMove -> Html msg
spare_to_move_row maybe_move =
    case maybe_move of
        Just chessmove ->
            let
                move =
                    1 + (chessmove.number // 2) |> fromInt

                td_move =
                    td [] [ text (move ++ ".") ]

                td_white =
                    td [] [ text chessmove.move ]
            in
            tr [] [ td_move, td_white ]

        Nothing ->
            tr [] []


white_black_to_row : ( ChessMove, ChessMove ) -> Html msg
white_black_to_row ( white, black ) =
    let
        move =
            1 + (white.number // 2) |> fromInt

        td_move =
            td [] [ text (move ++ ".") ]

        td_white =
            td [] [ text white.move ]

        td_black =
            td [] [ text black.move ]
    in
    tr [] [ td_move, td_white, td_black ]



-- fold list of moves into list of double moves white/black


fold_moves : ChessMove -> ( List ( ChessMove, ChessMove ), Maybe ChessMove ) -> ( List ( ChessMove, ChessMove ), Maybe ChessMove )
fold_moves chessmove ( list, maybe ) =
    case maybe of
        Just move ->
            let
                newlist =
                    List.append list [ ( move, chessmove ) ]
            in
            ( newlist, Nothing )

        Nothing ->
            ( list, Just chessmove )



--<div class="row">
--  <span class="col-2">&nbsp;</span>
--  <span class="col-2"><%= link_to '<<', @game.moves.first %></span>
--  <span class="col-2"><%= link_to '<', @game.moves.find_by(number: @move.number - 1) %></span>
--  <span class="col-2"><%= link_to '>', @game.moves.find_by(number: @move.number + 1) %></span>
--  <span class="col-2"><%= link_to '>>', @game.moves.last %></span>
--  <span class="col-2">&nbsp;</span>
--</div>


squaresToTableRow : Position -> List Square -> Html msg
squaresToTableRow position square_list =
    let
        tds =
            square_list |> List.map (squareToTableCell position)
    in
    tr [] tds


squareToTableCell : Position -> Square -> Html msg
squareToTableCell position square =
    let
        bg =
            class (squareColour square)

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
    case message of
        MovesLoaded result ->
            case result of
                Ok value ->
                    ( { model | moves = Just value }, Cmd.none )

                Err error ->
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
