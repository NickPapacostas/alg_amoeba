defmodule AmoebaFightShowTest do
  use ExUnit.Case
  use Benchfella
  import AmoebaFightShow

  test "basic implementation" do
    assert AmoebaFightShow.fight([5, 4, 6, 1, 3], &AmoebaFightShow.basic_choose_pair/1) == %{total: 19, time: 14}
  end

  test "better implementation" do
    assert AmoebaFightShow.fight([5, 4, 6, 1, 3], &AmoebaFightShow.biggest_first/1) == %{total: 19, time: 13}
  end

  # test "ubertester" do
  #   all = for _z <- 0..5000 do 
  #     rands = for _y <- 0..Enum.random(10..5), do: Enum.random(0..1000)
  #     {
  #       length(rands), 
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.basic_choose_pair/1),
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.biggest_first/1),
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.heap_min/1),
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.heap_max/1)
  #     } 
  #   end

  #   basic_better = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> b < bf && b < hmin end) 
  #   IO.puts "basic choose best"
  #   IO.puts length(basic_better)

  #   biggest_first = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> bf < b && bf < hmin end) 
  #   IO.puts "biggest first best"
  #   IO.puts length(biggest_first)

  #   IO.puts heap = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> hmin < b && hmin < bf end) 
  #   IO.puts "heap best"
  #   IO.puts length(heap)

  #   heap_and_biggest = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> hmin < b && hmin == bf end) 
  #   IO.puts "heap and biggest tied"
  #   IO.puts length(heap_and_biggest)

  #   heap_max_biggest = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> hmax <= Enum.min([b, bf, hmin]) end) 
  #   IO.puts "heap max biggest"
  #   IO.puts length(heap_max_biggest)

  #   equal = Enum.filter(all, fn({_len, b, bf, hmin, hmax}) -> bf == hmin end) 
  #   IO.puts "equal"
  #   IO.puts length(equal)    
  # end

  # bench "heap test" do
  #   all = for _z <- 0..5000 do 
  #     rands = for _y <- 0..Enum.random(10..5), do: Enum.random(0..1000)
  #     basic = AmoebaFightShow.fight(rands, &AmoebaFightShow.basic_choose_pair/1)

  #     {
  #       length(rands), 
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.basic_choose_pair/1), 
  #       AmoebaFightShow.fight(rands, &AmoebaFightShow.biggest_first/1)
  #     } 
  #   end

  # end
end
