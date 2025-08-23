defmodule Collatz do
  def collatz_len_and_peak(x) do
    collatz_len_and_peak(x, 0, x)
  end

  defp collatz_len_and_peak(1, steps, peak), do: {steps, peak}

  defp collatz_len_and_peak(n, steps, peak) when rem(n, 2) == 0 do
    new_n = div(n, 2)
    new_peak = max(new_n, peak)
    collatz_len_and_peak(new_n, steps + 1, new_peak)
  end

  defp collatz_len_and_peak(n, steps, peak) do
    new_n = 3 * n + 1
    new_peak = max(new_n, peak)
    collatz_len_and_peak(new_n, steps + 1, new_peak)
  end

  def scan_upto(limit) do
    1..limit
    |> Enum.reduce({1, 0, 1, 0}, fn n, {best_n, best_steps, best_peak, xor_steps} ->
      {steps, peak} = collatz_len_and_peak(n)
      new_xor_steps = Bitwise.bxor(xor_steps, steps)

      if steps > best_steps do
        {n, steps, peak, new_xor_steps}
      else
        {best_n, best_steps, best_peak, new_xor_steps}
      end
    end)
  end

  def main do
    IO.puts("hello world!")

    n = 1_000_000
    {best_n, best_steps, best_peak, xor_steps} = scan_upto(n)

    IO.puts("collatz_longest(1..#{n})")
    IO.puts("n*=#{best_n}")
    IO.puts("steps=#{best_steps}")
    IO.puts("peak=#{best_peak}")
    IO.puts("xor_steps=#{xor_steps}")
  end
end

Collatz.main()
