defmodule BlackCoffee.PingPong do
  @moduledoc false

  @delay_ms 2_000

  def new_ponger do
    spawn(&pong/0)
  end

  def new_pinger(ponger) do
    spawn(fn -> ping(ponger) end)
  end

  @spec ping(atom()) :: no_return()
  def ping(ponger) do
    # Let's send ping to ponger
    send(ponger, {:ping, self()})

    # After we have sent the :pong, let's wait to receive a :pong back
    receive do
      :pong ->
        IO.puts("I received a +pong+ from #{inspect(ponger)}")
    end

    Process.sleep(@delay_ms)
    ping(ponger)
  end

  defp pong do
    receive do
      {:ping, from} ->
        IO.puts("I received a -ping- from #{inspect(from)}")
        send(from, :pong)
    end

    # Let's do this again :)
    pong()
  end
end
