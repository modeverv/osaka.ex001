{:ok, manager} = GenEvent.start_link
stream = GenEvent.stream manager
spawn_link = fn -> for x <- stream, do: IO.inspect x end
GenEvent.notify manager, "aaaaa"
GenEvent.notify manager, "bbbb"

