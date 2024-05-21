import React, {useEffect} from 'react'
import {useState} from 'react';

export function Movelist({game, moves_url}) {
    const [getgame, setGame] = useState(game);
    const [moves, setMoves] = useState([])
    useEffect(() => {
        fetch(moves_url)
            .then((res) => {
                return res.json();
            })
            .then((data) => {
                console.log(data);
                setMoves(data);
            });
    }, []);

    return <div>
        React MoveList
        <ol>
            {moves.map((move) => (
                <li key={move.number}>{move.move}</li>
            ))}
        </ol>
    </div>
}
