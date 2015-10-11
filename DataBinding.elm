module DataBinding where
import Html exposing (text, input, div, Html)
import Html.Attributes exposing (type')
import Html.Events exposing (on, targetValue)

--Model
type alias Model = String

-- Update 
type Action = UpdateText String

update : Action -> Model -> Model
update action model =
    case action of
        UpdateText newStr -> 
            newStr


-- view
view : Signal.Address Action -> Model -> Html
view address model =
    div [] [
        input [type' "text", on "input" targetValue (\str -> Signal.message address (UpdateText str))][]
        , div [] [text model]
    ]