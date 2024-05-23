const odd_files = ['a', 'c', 'e', 'g'];
const odd_ranks = [1, 3, 5, 7];

function square_colour(square) {
    const odd_row = odd_ranks.includes(square.rank);
    const odd_col = odd_files.includes(square.file);
    if ((odd_row && !odd_col) || (!odd_row && odd_col)) {
        return "light-square";
    } else {
        return "dark-square";
    }
}

function piece_color(side_name) {
    if (side_name === "white") {
        return "l"
    } else {
        return "d"
    }
}

const piece_types = {
    'queen': 'q',
    'king': 'k',
    'knight': 'n',
    'bishop': 'b',
    'pawn': 'p',
    'rook': 'r'
}

function piece_glyph(piece) {
    const first = piece_types[piece.type];
    const second = piece_color(piece.side.name);

    return first + second + 't';
}


export {square_colour, piece_glyph};

