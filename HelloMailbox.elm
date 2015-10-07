import Task exposing (Task)
import Graphics.Element exposing (show, Element)

main : Signal Element
main =
    Signal.map show contentMailbox.signal 

contentMailbox : Signal.Mailbox String
contentMailbox =
    Signal.mailbox ""

port updateContent : Task x ()
port updateContent =
    Signal.send contentMailbox.address "hello"