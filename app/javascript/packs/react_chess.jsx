import React from 'react'
import PropTypes from 'prop-types'
import {useState} from 'react';
import {createRoot} from 'react-dom/client';

import Chess from 'chess';
import {piece_glyph, square_colour} from "../chess/board";

const reversed_ranks = [8, 7, 6, 5, 4, 3, 2, 1];

function ChessBoard({name}) {
    const [game, setGame] = useState(Chess.create());

    const board_squares = game.getStatus().board.squares

    const squares_in_ranks = reversed_ranks.map((rank_number, index) => {
        return board_squares.filter((square) => {
            return square.rank === rank_number;
        });
    });

    const table_rows = squares_in_ranks.map((rank_array, index) => {
        const table_cells = rank_array.map((square, index) => {
            const color = square_colour(square);
            const cell_key = '' + square.rank + square.file;

            if (square.piece === null) {
                return <td height="45" width="45" className={color} key={cell_key}></td>
            } else {
                const piece_file = "/pieces/Chess_" + piece_glyph(square.piece) + "45.svg";
                return <td height="45" width="45" className={color} key={cell_key}>
                    <img alt="piece" src={piece_file}></img>
                </td>
            }
        });
        const rank_key = "rank" + index
        return <tr key={rank_key}>{table_cells}</tr>
    });

    return <div>
        {name} Chessboard
        <table>
            <tbody>{table_rows}</tbody>
        </table>
    </div>
}

ChessBoard.propTypes = {
    name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('react_chessboard');

    const root = createRoot(target);
    root.render(
        <ChessBoard name="React"/>
    );
})
