defmodule RubberDuck.ChatCompletion.OpenAI do
  @moduledoc """
  For better handling of OpenAI, see: https://benreinhart.com/blog/openai-streaming-elixir-phoenix-part-2/
  """

  @chat_completions_url "https://api.openai.com/v1/chat/completions"

  @behaviour RubberDuck.ChatCompletion

  @impl RubberDuck.ChatCompletion
  def call(request, opts) when is_binary(request) do
    call(%{model: "gpt-3.5-turbo", messages: [%{role: "user", content: request}]}, opts)
  end

  def call(%{} = request, opts) do
    {callback, _opts} = Keyword.pop(opts, :callback)

    case callback do
      f when is_function(f, 1) ->
        Req.post(@chat_completions_url,
          json: Map.put(request, :stream, true),
          auth: {:bearer, api_key()},
          into: fn {:data, data}, context ->
            callback.(data)
            {:cont, context}
          end
        )

      _ ->
        Req.post(@chat_completions_url,
          json: request,
          auth: {:bearer, api_key()}
        )
    end
  end

  defp api_key do
    Application.get_env(:rubber_duck, :open_ai_key)
  end
end
