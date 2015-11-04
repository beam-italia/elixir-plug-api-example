defmodule User do
  @derive [Poison.Encoder]
  defstruct [:name, :surname]
end
