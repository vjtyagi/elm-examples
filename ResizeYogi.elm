import Graphics.Element exposing (..)
import Mouse

main : Signal Element
main =
    Signal.map getImage getSize

getImage : Int -> Element
getImage n =
    image n n  "imgs/yogi.jpg"

getSize : Signal Int
getSize =
    Signal.map (\(x, y) -> max x y ) Mouse.position