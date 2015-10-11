import DataBinding exposing (update, view)
import Html exposing (Html)
import Debug
main =
    start { model = "", update = update, view = view}

type alias Config model action = {
      model : model
    , update : action -> model -> model
    , view : Signal.Address action -> model -> Html
}

start : Config model action -> Signal Html

start config =
    let
        actions =
            Signal.mailbox Nothing
        address =
            Signal.forwardTo actions.address Just

        update action model =
            case action of
                Just action ->
                    config.update action model
                Nothing ->
                    Debug.crash "This shouldn't happen"

        -- generate model signal from actions
        model = Signal.foldp update config.model actions.signal

    in 
        Signal.map (config.view address) model