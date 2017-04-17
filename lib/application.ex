defmodule MulticastTest.Application do
  use Application

  def start(_, _) do
    MulticastTest.Supervisor.start_link
  end

end
