import Counter exposing (view, update, Model, init, Action)
import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Debug

main : Signal Html
main = 
    start { model = model, update = update, view = view }

type alias Config model action = 
    { view : Signal.Address action -> model -> Html
    , update : action -> model -> model
    , model : model
    }

start :  Config model action -> Signal Html

start config =
    let
        actionMailBox = 
            Signal.mailbox Nothing
        actionMailBoxAddress =
            Signal.forwardTo actionMailBox.address Just

        update action model =
            case action of
                Just act ->
                    config.update act model
                Nothing ->
                    Debug.crash "This shouldn't happen"

        model = Signal.foldp update config.model actionMailBox.signal

    in 
        Signal.map (config.view actionMailBoxAddress ) model

-- Model 
type alias Model = 
    { top: Counter.Model, bottom: Counter.Model }

model : Model
model =
    init 0 0

-- Init
init : Int -> Int -> Model
init topCounter bottomCounter =
    {
        top = Counter.init topCounter
    ,   bottom =  Counter.init bottomCounter
    }

-- Actions
type Action =
    Reset
        | Top Counter.Action
        | Bottom Counter.Action

-- Update 
update : Action -> Model -> Model
update action model =
    case action of
        Top act ->
            { model | top <- Counter.update act model.top }
        Bottom act ->
            { model | bottom <- Counter.update act model.bottom }
        Reset ->
            init 0 0

-- View
view : Signal.Address Action -> Model -> Html
view address model =
    div [] [
            Counter.view (Signal.forwardTo address Top) model.top
           ,Counter.view (Signal.forwardTo address Bottom ) model.bottom
           , button [onClick address Reset] [text "Reset"]
    ]




