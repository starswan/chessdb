const reversed_ranks = [8, 7, 6, 5, 4, 3, 2, 1];

import Chess from 'chess';

export default class Game {
    constructor() {
        this.node_chess = Chess.create();
    }

    getSquares() {
        const board_squares = this.node_chess.getStatus().board.squares

        return reversed_ranks.map((rank_number) => {
            return board_squares.filter((square) => {
                return square.rank === rank_number;
            });
        });
    }
}

