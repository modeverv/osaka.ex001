defmodule KV do
  def start_link do
    spawn_link(fn -> loop(%{}) end)
  end

  def loop(map) do
    receive do
      {:get, key, caller} ->
        send(caller, Map.get(map, key))
        loop(map)

      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

pid = KV.start_link()
Process.register(pid, :server)

spawn_link(fn ->
  send(:server, {:put, "園田ことり劇場11回", "いくよFull Combo!"})
end)

spawn_link(fn ->
  send(:server, {:put, "隣の人フルコンします", "この曲好き！"})
end)

spawn_link(fn ->
  send(:server, {:get, "園田ことり劇場11回", self()})

  receive do
    value -> IO.puts("園田ことり劇場11回「#{value}」")
  end
end)

spawn_link(fn ->
  send(:server, {:get, "隣の人フルコンします", self()})

  receive do
    value -> IO.puts("隣の人フルコンします「#{value}」")
  end
end)
