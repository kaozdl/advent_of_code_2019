defmodule AdventDay2 do

  defp to_int([head | tail]) do
    [String.to_integer(head) | to_int(tail)]
  end

  defp to_int([]) do
    []
  end

  defp openf() do
    File.read!("input")
    |> String.slice(0..-2)
    |> String.split(",", [])
    |> to_int
  end

  defp required_replaces(list) do
    list
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
  end
  
  defp oper(1, a, b) do
    a + b
  end

  defp oper(2, a, b) do
    a * b
  end

  defp execute(code, inst) do
    oop = Enum.at(inst, 0)
    a = Enum.at(code, Enum.at(inst, 1))
    b = Enum.at(code, Enum.at(inst, 2))
    addr = Enum.at(inst, 3)
    code
    |> List.replace_at(addr,oper(oop,a,b))
  end

  defp compute(code, pos) do
    if Enum.at(code, pos) == 99 do
      code
    else
      inst = code
             |> Enum.slice(pos..pos + 3)
      execute(code, inst)
      |> compute(pos + 4)
    end
  end
  

  def challenge() do
    openf()
    |> required_replaces
    |> compute(0)
    |> hd
  end
end
