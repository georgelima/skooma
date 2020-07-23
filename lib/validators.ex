defmodule Skooma.Validators do
  defp stringify_path(path, nil) do
    if Enum.count(path) == 0, do: "O valor", else: Enum.join(path, ".")
  end

  defp stringify_path(_path, field_name) do
    field_name
  end

  def min_length(min, field_name \\ nil) do
    fn data, path ->
      bool = String.length(data) >= min

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ter no mínimo #{min} caracteres"}
      end
    end
  end

  def max_length(max, field_name \\ nil) do
    fn data, path ->
      bool = String.length(data) <= max

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ter no máximo #{max} caracteres"}
      end
    end
  end

  def regex(regex, field_name \\ nil) do
    fn data, path ->
      bool = Regex.match?(regex, data)

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ter o formato: #{inspect(regex)}"}
      end
    end
  end

  def inclusion(values_list, field_name \\ nil) when is_list(values_list) do
    fn data, path ->
      bool = data in values_list

      if bool do
        :ok
      else
        {:error,
         "#{stringify_path(path, field_name)} não está inclúido nas opcões: #{
           Enum.join(values_list, ", ")
         }"}
      end
    end
  end

  def gt(value, field_name \\ nil) do
    fn data, path ->
      bool = data > value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ser maior que #{value}"}
      end
    end
  end

  def gte(value, field_name \\ nil) do
    fn data, path ->
      bool = data >= value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ser maior ou igual a #{value}"}
      end
    end
  end

  def lt(value, field_name \\ nil) do
    fn data, path ->
      bool = data < value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ser menor que #{value}"}
      end
    end
  end

  def lte(value, field_name \\ nil) do
    fn data, path ->
      bool = data < value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path, field_name)} precisa ser menor ou igual a #{value}"}
      end
    end
  end
end
