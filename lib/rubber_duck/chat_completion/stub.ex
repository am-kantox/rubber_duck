defmodule RubberDuck.ChatCompletion.Stub do
  @behaviour RubberDuck.ChatCompletion

  @impl RubberDuck.ChatCompletion
  def call(request, _opts) do
    "Hi, as a stub code, I can only mirror your request: ‹#{request}›"
  end
end
