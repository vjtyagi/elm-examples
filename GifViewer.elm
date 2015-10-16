module GifViewer exposing (update, view) where
import Effects


-- Model
type alias Model = {
      topic : String
    , url : String
}

-- init
init : String -> (Model, Effects Action)

-- Action
type Action =
    RequestMore
    | NewGif (Maybe String)



-- update
update : Action -> Model -> (Model, Effects Action) 
update action model =
    case action of
        RequestMore ->
            (model, getRandomGif model.topic model.url)
        NewGif maybeUrl ->
            (Model model.topic (MayBe.withDefault model.url maybeUrl )
            , Effects.none )