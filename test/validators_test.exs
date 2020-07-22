defmodule ValidatorsTest do
  use ExUnit.Case
  alias Skooma.Validators

  test "min function" do
    test_data = "abc"
    test_schema = [:string, Validators.min_length(4)]
    expected_results = {:error, ["O valor precisa ter no mínimo 4 caracteres"]}

    results = Skooma.valid?(test_data, test_schema)

    assert(expected_results == results)
  end

  test "max function" do
    test_data = "abcdefghijk"
    test_schema = [:string, Validators.max_length(7)]
    expected_results = {:error, ["O valor precisa ter no máximo 7 caracteres"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  test "regex function" do
    test_data = "duck"
    test_schema = [:string, Validators.regex(~r/foo/), Validators.min_length(4)]
    expected_results = {:error, ["O valor precisa ter o formato: ~r/foo/"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  test "custom function" do
    test_data = 8
    test_schema = [:int, &(&1 == 0)]
    expected_results = {:error, ["O valor não combina com o validador customizado"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  # test "inclusion function" do
  #   test_data = 15
  #   test_schema = [:list, Validators.inclusion([1..5])]
  #   expected_results = {:error, [" Value is not included in the options: [1..5]"]}

  #   results = Skooma.valid?(test_data, test_schema)
  #   assert(expected_results == results)
  # end

  test "gt function" do
    test_data = 6
    test_schema = [:int, Validators.gt(6)]
    expected_results = {:error, ["O valor precisa ser maior que 6"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  test "gte function" do
    test_data = 5
    test_schema = [:int, Validators.gte(6)]
    expected_results = {:error, ["O valor precisa ser maior ou igual a 6"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  test "lt function" do
    test_data = 4
    test_schema = [:int, Validators.lt(4)]
    expected_results = {:error, ["O valor precisa ser menor que 4"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end

  test "lte function" do
    test_data = 5
    test_schema = [:int, Validators.lte(4)]
    expected_results = {:error, ["O valor precisa ser menor ou igual a 4"]}

    results = Skooma.valid?(test_data, test_schema)
    assert(expected_results == results)
  end
end
