import Counter exposing (update, view)
import Debug
main =
    start { model = 0, view = view, update = update }

type alias config model action =
    { model : model
    , view : Address action -> model -> Html
    , update: action -> model -> model
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
        model = Signal.foldp update config.model actions.signal

    in 
        Signal.map (config.view address) model
