defmodule MulticastTest.Broadcast do
  use GenServer

    def start_link do
      IO.puts "Starting broadcast listener"
      GenServer.start_link(__MODULE__, :ok, name: :broadcast_listener)
    end

    def init (:ok) do
      udp_options = [
        :binary,
        reuseaddr:       true,
        broadcast:       true
      ]

      {:ok, _socket} = :gen_udp.open(49998, udp_options)
    end

    def handle_info({:udp, _socket, ip, port, data}, state)
    do
      IO.puts "Received broadcast"
      IO.inspect [ip, port, data]
      {:noreply, state}
    end
end

#socat STDIO UDP4-DATAGRAM:255.255.255.255:49998,broadcast
