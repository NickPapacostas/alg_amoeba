defmodule AmoebaFightShowTest do
  use ExUnit.Case
  import AmoebaFightShow

  test "basic implementation" do
    assert AmoebaFightShow.fight([5, 4, 6, 1, 3]) == %{total: 19, time: 14}
  end

  test "better implementation" do
    assert AmoebaFightShow.better_fight([5, 4, 6, 1, 3]) == %{total: 19, time: 13}
  end

  test "ubertester" do
    all = for _z <- 0..5000 do 
      rands = for _y <- 0..Enum.random(10..5), do: Enum.random(0..1000)
      {length(rands), AmoebaFightShow.fight(rands), AmoebaFightShow.better_fight(rands)} 
    end |> List.keysort(0)

    basic_better = Enum.filter(all, fn({_len, b, bm}) -> b < bm end) 
    length(basic_better)

    better_better = Enum.filter(all, fn({_len, b, bm}) -> b > bm end) 
    length(better_better)

    equal = Enum.filter(all, fn({_len, b, bm}) -> b == bm end) 
    length(equal)

  end
end
