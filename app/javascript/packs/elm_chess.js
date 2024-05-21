// Run this example by adding <%= javascript_pack_tag "chessboard" %> to the
// head of your layout file, like app/views/layouts/application.html.erb.
// It will render "Hello Elm!" within the page.

import {
    Elm
} from '../Main'

document.addEventListener('DOMContentLoaded', () => {
    const target = document.getElementById('elm_chessboard');

    Elm.Main.init({
        node: target,
        flags: target.getAttribute('data-moves-url')
    })
})
