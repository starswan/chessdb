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

export function Movelist({game}) {
    const [getgame, setGame] = useState(game);
    const [moves, setMoves] = useState([])
    useEffect(() => {
        game.getMoves()
            .then((data) => {
                const folded = data.reduce(fold_moves, { list: [], spare: null })
                if (folded.spare !== null) {
                    folded.list.push({ number: folded.spare.number, white: folded.spare.move, black: null})
                }
                setMoves(folded.list);
            });
    }, []);

    const move_list = moves.map((move, index) => {
        if (move.black !== null) {
            return <tr key={move.number}><td>{index + 1}.</td><td>{move.white}</td><td>{move.black}</td></tr>;
        } else {
            return <tr key={move.number}><td>{index + 1}.</td><td>{move.white}</td></tr>;
        }
    });

    return <div>
        React MoveList
        <table className="table table-striped table-sm">
            <tr>
                <th></th>
                <th>White</th>
                <th>Black</th>
            </tr>
            {move_list}
        </table>
    </div>
}
