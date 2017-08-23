defmodule AmoebaFightShowTest do
  # use ExUnit.Case
  use Benchfella
  import AmoebaFightShow

  bench "heap test" do
    all = for _z <- 0..5000 do 
      rands = for _y <- 0..Enum.random(10..5), do: Enum.random(0..1000)
      {
        length(rands), 
        AmoebaFightShow.fight(rands, &AmoebaFightShow.basic_choose_pair/1), 
        AmoebaFightShow.fight(rands, &AmoebaFightShow.biggest_first/1)
      } 
    end

  end
end
