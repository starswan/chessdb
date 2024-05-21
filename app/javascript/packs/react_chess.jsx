import React from 'react'
import {createRoot} from 'react-dom/client';
import {ChessBoard} from "../chess/chessboard";

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('react_chessboard');

    const root = createRoot(target);
    root.render(
        <ChessBoard name="React"/>
    );
})
