import React from 'react'
import {createRoot} from 'react-dom/client';
import {ChessBoard} from "../chess/chessboard";
import Game from "../chess/game"

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('react_chessboard');

    const root = createRoot(target);
    const game = new Game();
    root.render(
        <ChessBoard game={game}/>
    );
})
