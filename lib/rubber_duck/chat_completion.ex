defmodule RubberDuck.ChatCompletion do
  @moduledoc "Behaviour to be implemented by chat completion engines"

  @callback call(any()) :: {:ok, String.t()} | {:error, term}

  def call(request, engine \\ RubberDuck.ChatCompletion.OpenAi) do
    engine.call(request)
  end
end
