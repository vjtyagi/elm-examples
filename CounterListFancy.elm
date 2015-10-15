module CounterListFancy (update, view, init) where
import Counter exposing(Model, viewWithRemoveButton, init, Context)
import Html exposing (div, button, text, Html)
import Html.Events exposing (onClick)

-- Model
type alias Model = {
      counters : List (ID, Counter.Model)
    , nextID : ID    
}

type alias ID = Int

init : Model
init = 
    {
      counters = []
    , nextID = 0
    }

-- Action
type Action =
    Insert 
     | Remove ID
     | Modify ID Counter.Action


-- Update
update : Action -> Model -> Model
update action model =
    case action of
        Insert ->
            { model | 
                  counters <- (model.nextID, Counter.init 0) :: model.counters
                , nextID <- model.nextID + 1
            }

        Remove id ->
            { model | counters <- List.filter (\(currentId, _) -> currentId /= id) model.counters }

        Modify id counterAction ->
            let
                updateCounter (counterId, counterModel) =
                    if counterId == id 
                        then (counterId, Counter.update counterAction counterModel)
                        else (counterId, counterModel) 
            in 
                {model | counters <- List.map updateCounter model.counters }
-- View
view : Signal.Address Action -> Model -> Html
view address model =
    let
        insert = button [onClick address Insert] [text "Insert"]

    in 
        div [] (insert :: List.map (viewCounter address) model.counters)

viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (counterID, counterModel) =
    let context =
        Counter.Context 
            (Signal.forwardTo address (Modify counterID))
            (Signal.forwardTo address (always (Remove counterID) )) 
    in 
        Counter.viewWithRemoveButton context counterModel
















