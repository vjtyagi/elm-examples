module GifViewer exposing (update, view) where
import Effects


-- Model
type alias Model = {
      topic : String
    , url : String
}

-- init
init : String -> (Model, Effects Action)
init topic =
    (Model topic "assets/waiting.gif", getRandomGif model.topic )

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

getRandomGif : String -> Effects Action
getRandomGif topic =
    Http.get decodeImageUrl (randomUrl topic)
        |> Task.toMaybe
        |> Task.map NewGif
        |> Effects.task

randomUrl : String -> String
randomUrl topic =
    Http.url "http://api.giphy.com/v1/gifs/random"
        ["api_key" => "dc6zaTOxFJmzC", "tag" => topic]


decodeImageUrl : Json.Decoder String
decodeImageUrl =
    Json.at ["data", "image_url"] Json.string