defmodule AmoebaFightShow do
  def fight(amoebas, time \\ 0)
  def fight([one_big_amoeba], time), do: %{total: one_big_amoeba, time: time}
  def fight(amoebas, time) do
    {pair, new_amoebas} = choose_pair(amoebas)
    fight(new_amoebas, time + Enum.min(pair))
  end

  def better_fight(amoebas, time \\ 0)
  def better_fight([one_big_amoeba], time), do: %{total: one_big_amoeba, time: time}
  def better_fight(amoebas, time) do
    {pair, new_amoebas} = better_choose_pair(amoebas)
    better_fight(new_amoebas, time + Enum.min(pair))
  end

  def choose_pair([first, second | rest]) do
    {[first, second], [first + second | rest]}
  end

  def better_choose_pair(amoebas) do
    {max_val, max_index} = 
      amoebas
      |> Enum.with_index 
      |> Enum.max_by(fn({v, _i}) -> v end)


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
