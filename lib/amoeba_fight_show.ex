defmodule AmoebaFightShow do
  def fight(amoebas, choosing_func, time \\ 0)
  def fight([one_big_amoeba], _choosing_func, time), do: %{total: one_big_amoeba, time: time}
  def fight(amoebas, choosing_func, time) do
    {pair, new_amoebas} = choosing_func.(amoebas)
    fight(new_amoebas, choosing_func, time + Enum.min(pair))
  end

  def heap_min(amoebas) do
    {max_val, max_index} = amoebas 
      |> Enum.with_index 
      |> Enum.into(Heap.min)
      |> Heap.root

    fight_smallest_neighbor(amoebas, max_val, max_index)
  end

  def heap_max(amoebas) do
    {max_val, max_index} = amoebas 
      |> Enum.with_index 
      |> Enum.into(Heap.max)
      |> Heap.root

    fight_smallest_neighbor(amoebas, max_val, max_index)
  end

  def basic_choose_pair([first, second | rest]) do
    {[first, second], [first + second | rest]}
  end

  def biggest_first(amoebas) do
    {max_val, max_index} = 
      amoebas
      |> Enum.with_index 
      |> Enum.max_by(fn({v, _i}) -> v end)

    fight_smallest_neighbor(amoebas, max_val, max_index)
  end

  def fight_smallest_neighbor(amoebas, max_val, max_index) do
    if max_index == 0 do
      {[max_val, Enum.at(amoebas, 1)], [max_val + Enum.at(amoebas, 1) | Enum.slice(amoebas, 2..-1)]}
    else
      [one_less, one_more] = [Enum.at(amoebas, max_index - 1), Enum.at(amoebas, max_index + 1)]
      if one_more == nil do 
        {[max_val, one_less], amoebas |> delete_and_replace(max_index - 1, max_index, max_val + one_less)}
      else 
        case Enum.max([one_more, one_less]) do
          ^one_less -> 
            {[max_val, one_less], amoebas |> delete_and_replace(max_index - 1, max_index, max_val + one_less)}
          ^one_more -> 
            {[max_val, one_more], amoebas |> delete_and_replace(max_index + 1, max_index, max_val + one_more)}
        end
      end
    end
  end

  defp delete_and_replace(list, delete_index, replace_index, replace_amount) do
    list 
    |> List.replace_at(replace_index, replace_amount)
    |> List.delete_at(delete_index) 
  end
end
