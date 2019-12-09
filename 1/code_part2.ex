defmodule AdventDay1Part2 do

  defp sub2(input) do
    input - 2
  end
  
  defp div3(input) do
    input / 3
  end

  defp cost(input) do
    input
    |> div3
    |> trunc
    |> sub2
  end

  defp calculate_with_fuel_cost(input) do
    fuel_cost = cost(input)
    if fuel_cost > 0 do
      fuel_cost + calculate_with_fuel_cost(fuel_cost)
    else
      0
    end
  end

  defp calculate(input) do
    if input == [[]] do
      0
    else
      input
      |> calculate_with_fuel_cost
    end
  end

  defp to_int([head | tail]) do
    if head == "" do
      [to_int(tail)]
    else
      [String.to_integer(head) | to_int(tail)]
    end
  end

  defp to_int([]) do
    []
  end

  defp reduce_challenge([head | tail], acc) do
    reduce_challenge(tail, calculate(head) + acc)
  end

  defp reduce_challenge([], acc) do
    acc
  end

  def challenge() do
    File.read!("input")
    |> String.split("\n", [])
    |> to_int()
    |> reduce_challenge(0)
  end
end
