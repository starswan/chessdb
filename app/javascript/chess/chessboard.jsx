import React from 'react'
import {piece_glyph, square_colour} from "./board";
import Game from "./game"
import PropTypes from 'prop-types'
import {useState} from 'react';

export function ChessBoard({name}) {
    const [game, setGame] = useState(new Game());

    const table_rows = game.getSquares().map((rank_array, index) => {
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

