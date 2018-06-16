defmodule KV.Registry do
  use GenServer

  # Client API

  def start_link(table, manager, buckets, opts \\ []) do
    GenServer.start_link(__MODULE__, {table, manager, buckets}, opts)
  end

  def lookup(table, name) do
    case :ets.lookup(table, name) do
      [{^name, bucket}] -> {:ok, bucket}
      [] -> :error
    end
  end

  def create(server, name) do
    GenServer.call(server, {:create, name})
  end

  # Server Callbacks

  def init({ets, events, buckets}) do
    # ets = :ets.new(table, [:named_table, read_concurrency: true])
    refs = HashDict.new()
    {:ok, %{names: ets, refs: refs, events: events, buckets: buckets}}
  end

  def handle_call({:create, name}, _from, state) do
    case lookup(state.names, name) do
      [:ok, pid] ->
        {:reply, pid, state}

      :error ->
        {:ok, bucket} = KV.Bucket.Supervisor.start_bucket(state.buckets)
        ref = Process.monitor(bucket)
        refs = HashDict.put(state.refs, ref, name)
        :ets.insert(state.names, {name, bucket})
        GenEvent.sync_notify(state.events, {:create, name, bucket})
        {:reply, bucket, %{state | refs: refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, state) do
    {name, refs} = HashDict.pop(state.refs, ref)
    :ets.delete(state.names, name)
    GenEvent.sync_notify(state.events, {:exit, name, _pid})
    {:noreply, %{state | refs: refs}}
  end

  def handle_info(msg, state) do
    {:noreply, state}
  end
end
