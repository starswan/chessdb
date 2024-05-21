import React, {useEffect} from 'react'
import {useState} from 'react';

function fold_moves(listwithspare, target) {
    const spare = listwithspare.spare;
    if (spare === null) {
        return { list: listwithspare.list, spare: target }
    } else {
        const newitem = {number: spare.number, white: spare.move, black: target.move };
        listwithspare.list.push(newitem);
        return { list: listwithspare.list, spare: null }
    }
}

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
                const folded = data.reduce(fold_moves, { list: [], spare: null })
                setMoves(folded.list);
            });
    }, []);

    const move_list = moves.map((move) => {
        const item = move.white + ' ' + move.black;

        return <li key={move.number}>{item}</li>;
    });

    return <div>
        React MoveList
        <ol>{move_list}</ol>
    </div>
}
