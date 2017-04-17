defmodule MulticastTest.Multicast do
  use GenServer

    def start_link do
      IO.puts "Starting multicast listener"
      GenServer.start_link(__MODULE__, :ok, name: :multicast_listener)
    end

    def init (:ok) do
      udp_options = [
        :binary,
        active:          10,
        add_membership:  { {224,1,1,1}, {0,0,0,0} },
        multicast_if:    {0,0,0,0},
        multicast_loop:  false,
        multicast_ttl:   4,
        reuseaddr:       true
      ]

      {:ok, _socket} = :gen_udp.open(49999, udp_options)
    end

    def handle_info({:udp, socket, ip, port, data}, state)
    do
      # when we popped one message we allow one more to be buffered
      :inet.setopts(socket, [active: 1])
      IO.puts "Received multicast"
      IO.inspect [ip, port, data]
      {:noreply, state}
    end
end

#nc -u 224.1.1.1 49999
