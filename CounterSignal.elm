import Counter exposing (update, view)

main =
    start { model = 0, view = view, update = update }

type alias config model action =
    { model : model
    , view : Address action -> model -> Html
    , update: action -> model -> model
    }