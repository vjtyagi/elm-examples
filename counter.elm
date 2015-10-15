module Counter (Model, Action, update, view, init, viewWithRemoveButton, Context) where
import Html exposing (div, text, button, Html, Attribute)
import Html.Events exposing(onClick)
import Html.Attributes exposing(style)

-- Model
type alias Model = Int

init : Int -> Model
init count = count

type alias Context = {
    actions : Signal.Address Action
  , remove : Signal.Address ()
}

-- View
view : Signal.Address Action -> Model -> Html
view address model =
    div [] [
         button[onClick address Increment][text "+"]
        ,div [countStyle] [text (toString model)]
        ,button [onClick address Decrement ][text "-"]
    ]

type Action = Increment | Decrement

-- Update
update : Action -> Model -> Model
update action model =
    case action of
        Increment ->
            model + 1
        Decrement ->
            model - 1


-- View with remove button 
viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div [][
      button [onClick context.actions Increment][text "+"]
    , div [countStyle][text (toString model)]
    , button [onClick context.actions Decrement] [text "-"]
    , div [countStyle] []
    , button [onClick context.remove ()] [text "X"]
  ]

-- Style
countStyle : Attribute
countStyle =
    style
         [ ("font-size", "20px")
          ,("font-family", "monospace")
          ,("display", "inline-block")
          ,("width", "50px")
          ,("text-align", "center")
         ]