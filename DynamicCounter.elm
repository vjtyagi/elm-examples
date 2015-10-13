import Counter exposing (Model, Action, view, update, init)
import StartApp.Simple exposing (start)
import Html exposing (button, Html, div, text)
import Html.Events exposing (onClick)

main = 
    start {model = init, view = view, update = update }

-- Model
type alias Model =
    {
         counters : List (ID, Counter.Model)
        ,nextID : ID
    }
type alias ID = Int

-- init
init : Model
init =
    { counters  = [], nextID = 0}

-- Action
type Action = 
    Insert
    | Remove
    | Modify ID Counter.Action

-- Update
update : Action -> Model -> Model
update action model =
    case action of
        Insert ->
            let 
                newCounter = (model.nextID, Counter.init 0)
                newCounters = model.counters ++ [newCounter]
            in
                { model | counters <- newCounters
                , nextID <- model.nextID + 1
                }

        Remove ->
            { model | counters <- List.drop 1 model.counters }

        Modify id act ->
            let updateCounter (currentId, counterModel) =
                if id == currentId
                    then (currentId, Counter.update act counterModel)
                    else (currentId, counterModel)
            in 
                {model | counters <- List.map updateCounter model.counters}


-- View
view : Signal.Address Action -> Model -> Html
view address model =
    let
        counters = List.map (viewCounter address) model.counters
        remove = button [onClick address Remove] [text "Remove"]
        insert = button [onClick address Insert] [text "Insert"]
    in 
        div [] (counters ++ [insert, remove])

viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id, model) =
    Counter.view (Signal.forwardTo address (Modify id ))  model


