import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Mouse
import Window

main : Signal Element
main =
    Signal.map2 scene Window.dimensions clickLocations

clickLocations : Signal (List (Int, Int) )
clickLocations =
    Signal.foldp (::) [] (Signal.sampleOn Mouse.clicks Mouse.position)

scene : (Int, Int) -> List (Int, Int) -> Element
scene (w, h) locs =
    let drawPentagon (x, y) =
        ngon 5 20
            |> filled (hsla (toFloat x) 0.9 0.6 0.7)
            |> move ( toFloat x - toFloat w/2, toFloat h/2 - toFloat y)
            |> rotate (toFloat x)
    in 
        layers
            [ collage w h (List.map drawPentagon locs)
            , show "click to stamp a pentagon"
            ]