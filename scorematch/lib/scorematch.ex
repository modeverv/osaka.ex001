defmodule Forwarder do
  use GenEvent

  def handle_event(event, parent) do
    send(parent, event)
    {:ok, parent}
  end
end

defmodule Scorematch do
  def main(args) do
    #    KV.Supervisor.start_link
    KV.Registry.create(KV.Registry, "card1")
    IO.inspect(KV.Registry.lookup(KV.Registry, "card1"))

    #    KV.Supervisor.start_link
    #    GenEvent.add_mon_handler KV.EventManager, Forwarder, self()
    #    KV.Registry.create KV.Registry, "card1"
    #    KV.Registry.create KV.Registry, "card2"

    #    {:ok, bucket} = KV.Registry.lookup KV.Registry, "card1"
    #    Process.exit bucket, :shutdown
    #    receive do
    #      {:exit, "card1", ^bucket} -> IO.puts "exit #{Kernel.inspect bucket}"
    #    end
    #    IO.inspect KV.Registry.lookup KV.Registry, "card1"
    #    IO.inspect KV.Registry.lookup KV.Registry, "card2"
  end
end
