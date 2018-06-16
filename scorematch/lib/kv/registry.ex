defmodule KV.Registry do
  use GenServer

  # Client API

  def start_link(manager, buckets, opts \\ []) do
    GenServer.start_link(__MODULE__, {manager, buckets}, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    IO.puts("create-client")
    GenServer.cast(server, {:create, name})
  end

  # Server API

  def init({events, buckets}) do
    names = HashDict.new()
    refs = HashDict.new()
    {:ok, %{names: names, refs: refs, events: events, buckets: buckets}}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, HashDict.fetch(state.names, name), state}
  end

  def handle_cast({:create, name}, state) do
    IO.puts("create-handle")

    if(HashDict.get(state.names, name)) do
      {:reply, {state.names, state.refs}}
    else
      IO.puts("create-else")
      {:ok, bucket} = KV.Bucket.Supervisor.start_bucket(state.buckets)
      ref = Process.monitor(bucket)
      refs = HashDict.put(state.refs, ref, name)
      names = HashDict.put(state.names, name, bucket)
      GenEvent.sync_notify(state.events, {:create, name, bucket})
      {:noreply, %{state | names: names, refs: refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, state) do
    {name, refs} = HashDict.pop(state.refs, ref)
    names = HashDict.delete(state.names, name)
    GenEvent.sync_notify(state.events, {:exit, name, _pid})
    {:noreply, %{state | names: names, refs: refs}}
  end

  def handle_info(msg, state) do
    {:noreply, state}
  end
end
