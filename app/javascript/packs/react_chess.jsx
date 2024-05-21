import React from 'react'
import {createRoot} from 'react-dom/client';
import {ChessBoard} from "../chess/chessboard";
import Game from "../chess/game"
import {Movelist} from "../chess/movelist";

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('react_chessboard');

    const root = createRoot(target);
    const game = new Game();
    root.render(
        <ChessBoard game={game}/>
    );

    const move_list = document.getElementById('react_movelist');
    const move_root = createRoot(move_list);

    const get_moves_url = move_list.getAttribute('data-moves-url')

    move_root.render(
        <Movelist game={game} moves_url={get_moves_url}/>
    );
})
