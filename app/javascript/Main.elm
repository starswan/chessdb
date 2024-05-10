--
-- $Id$
--


module Main exposing (..)

import Browser
import Html exposing (Html, div)


type alias Model =
    {}


type Message
    = Nothing


init : String -> ( Model, Cmd Message )
init data =
    ( Model, Cmd.none )


view : Model -> Html Message
view model =
    div [] []


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    ( Model, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


main : Program String Model Message
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
