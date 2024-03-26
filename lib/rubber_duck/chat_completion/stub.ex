defmodule RubberDuck.ChatCompletion.Stub do
  @behaviour RubberDuck.ChatCompletion

  @impl RubberDuck.ChatCompletion
  def call(request, opts) do
    response = "Hi, as a stub code, I can only mirror your request: ‹#{inspect(request)}›"
    {callback, _opts} = Keyword.pop(opts, :callback)

    case callback do
      f when is_function(f, 1) -> f.(response)
      _ -> response
    end
  end
end
