import Graphics.Element exposing (show)
import Time exposing (second, Time)
import TaskTutorial exposing(print)
import Task exposing (Task)


clock : Signal Time
clock =
    Time.every second

printTasks : Signal (Task x ())
printTasks =
    Signal.map print clock

port runner : Signal (Task x ())
port runner =
    printTasks

main =
    show "open developer's console"