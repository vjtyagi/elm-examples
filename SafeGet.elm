import Http
import Task exposing (andThen, toResult, Task)
import Graphics.Element exposing (show)
import Json.Decode as Json
import TaskTutorial exposing (print)

get : Task Http.Error (List String)
get =
    Http.get (Json.list Json.string) "http://example.com/hats-list.json"

safeget : Task x (Result Http.Error (List String) )
safeget =
    Task.toResult get
port runner : Task x ()
runner =
    safeget `andThen` print

main = 
    show "Show Developer's console"