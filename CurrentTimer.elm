import Graphics.Element exposing (show)
import TaskTutorial exposing (print, getCurrentTime)
import Task exposing (Task, andThen)

port runner : Task x ()
port runner = 
    getCurrentTime `andThen` print

main =
    show "Open developers console"
