defmodule Skooma.Basic do
  alias Skooma.Utils

  def validator(validator_, type, data, schema, path \\ []) do
    data
    |> validator_.()
    |> error(data, type, path)
    |> custom_validator(data, schema, path)
  end

  defp error(bool, data, expected_type, path) do
    data_type = Utils.typeof(data)

    if bool do
      :ok
    else
      cond do
        Enum.count(path) > 0 ->
          {:error,
           "Esperava um #{expected_type}, recebido #{data_type} #{inspect(data)}, em #{
             eval_path(path)
           }"}

        true ->
          {:error, "Esperava um #{expected_type}, recebido #{data_type} #{inspect(data)}"}
      end
    end
  end

  defp eval_path(path) do
    Enum.join(path, " -> ")
  end

  defp custom_validator(result, data, schema, path) do
    case result do
      :ok -> do_custom_validator(data, schema, path)
      _ -> result
    end
  end

  defp do_custom_validator(data, schema, path) do
    validators = Enum.filter(schema, &is_function/1)

    if Enum.count(validators) == 0 do
      :ok
    else
      Enum.map(validators, fn validator ->
        arity = :erlang.fun_info(validator)[:arity]

        cond do
          arity == 0 -> validator.()
          arity == 1 -> validator.(data)
          arity == 2 -> validator.(data, path)
        end
      end)
      |> Enum.reject(&(&1 == :ok || &1 == true))
      |> Enum.map(
        &if &1 == false, do: {:error, "O valor não combina com o validador customizado"}, else: &1
      )
    end
  end
end
