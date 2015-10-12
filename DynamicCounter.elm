import Counter exposing( update, view, Model, Action, init)
import StartApp.Simple exposing (start)

main =
    start { model = model, view = view, update = update }

-- Model
type alias Model = 
    {
      counters : List (ID, Counter.Model)
    , nextID : ID 
    
    }

type alias ID = Int 


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
            -- insert new Counter view

        Remove id ->
             -- remove this view
        Modify id act ->
            -- modify the counter view