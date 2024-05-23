import React from 'react'
import {createRoot} from 'react-dom/client';
import {ChessBoard} from "../chess/chessboard";
import Game from "../chess/game"
import {Movelist} from "../chess/movelist";

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('react_chessboard');

    const root = createRoot(target);
    const move_list = document.getElementById('react_movelist');
    const get_moves_url = move_list.getAttribute('data-moves-url')

    const game = new Game(get_moves_url);
    root.render(
        <ChessBoard game={game}/>
    );

    const move_root = createRoot(move_list);
    move_root.render(
        <Movelist game={game}/>
    );
})
