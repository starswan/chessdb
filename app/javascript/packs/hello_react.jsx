// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
// import { useState } from 'react';

// import Chess from 'chess';

function ChessBoard({name}) {
    return <div>
        Hello Chessboard {name}!
        <table border="1" class="table table-striped">
            <tr>
                <td>R1 T1</td>
                <td>R1 T2</td>
                <td>R1 T3</td>
            </tr>
            <tr>
                <td>R2 T1</td>
                <td>R2 T2</td>
                <td>R2 T3</td>
            </tr>
            <tr>
                <td>R3 T1</td>
                <td>R3 T2</td>
                <td>R3 T3</td>
            </tr>
        </table>
    </div>
}

//     <% position.each.with_index do |position_row, row_index| %>
// <tr>
// <% position_row.each_char.with_index do |piece, index| %>
// <td height="45" width="45" bgcolor="<%= square_colour(row_index + index) %>">
// <%= image_tag "/pieces/Chess_#{piece_glyph(piece)}45.svg", skip_pipeline: true unless piece == ' ' %>
// </td>
// <% end %>
// </tr>
// <% end %>


// ChessBoard.defaultProps = {
//   name: 'David'
// }

ChessBoard.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  const reactroot = document.body.appendChild(document.createElement('div'));
  const root = ReactDOM.createRoot(reactroot);
  root.render(
      <ChessBoard name="React" />
  );
  // ReactDOM.render(
  //   <Hello name="React" />,
  //   document.body.appendChild(document.createElement('div')),
  // )
})
