defmodule MulticastTest.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, nil, name: :network_supervisor)
  end

  def init(_) do
    processes = [
      worker(MulticastTest.Broadcast, []),
      worker(MulticastTest.Multicast, [])
    ]
    supervise(processes, strategy: :one_for_one)
  end
end
