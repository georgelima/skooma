defmodule Skooma.Validators do
  defp stringify_path(path) do
    if Enum.count(path) == 0, do: "O valor", else: Enum.join(path, ".")
  end

  def min_length(min) do
    fn data, path ->
      bool = String.length(data) >= min

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ter no mínimo #{min} caracteres"}
      end
    end
  end

  def max_length(max) do
    fn data, path ->
      bool = String.length(data) <= max

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ter no máximo #{max} caracteres"}
      end
    end
  end

  def regex(regex) do
    fn data, path ->
      bool = Regex.match?(regex, data)

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ter o formato: #{inspect(regex)}"}
      end
    end
  end

  def inclusion(values_list) when is_list(values_list) do
    fn data, path ->
      bool = data in values_list

      if bool do
        :ok
      else
        {:error,
         "#{stringify_path(path)} não está inclúido nas opcões: #{Enum.join(values_list, ", ")}"}
      end
    end
  end

  def gt(value) do
    fn data, path ->
      bool = data > value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ser maior que #{value}"}
      end
    end
  end

  def gte(value) do
    fn data, path ->
      bool = data >= value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ser maior ou igual a #{value}"}
      end
    end
  end

  def lt(value) do
    fn data, path ->
      bool = data < value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ser menor que #{value}"}
      end
    end
  end

  def lte(value) do
    fn data, path ->
      bool = data < value

      if bool do
        :ok
      else
        {:error, "#{stringify_path(path)} precisa ser menor ou igual a #{value}"}
      end
    end
  end
end
