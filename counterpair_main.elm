import CounterPair exposing (update, view, init)
import StartApp.Simple exposing (start)

main =
    start { model = init 0 0
          , update = update
          , view = view
          }