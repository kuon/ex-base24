defmodule Base24Test do
  use ExUnit.Case
  doctest Base24

  @values [
    "00000000",
    "ZZZZZZZ",
    "000000000000000000000000",
    "ZZZZZZZZZZZZZZZZZZZZZ",
    "00000001",
    "ZZZZZZA",
    "000000010000000100000001",
    "ZZZZZZAZZZZZZAZZZZZZA",
    "00000010",
    "ZZZZZZP",
    "00000030",
    "ZZZZZCZ",
    "88553311",
    "5YEATXA",
    "FFFFFFFF",
    "X5GGBH7",
    "FFFFFFFFFFFFFFFFFFFFFFFF",
    "X5GGBH7X5GGBH7X5GGBH7",
    "FFFFFFFFFFFFFFFFFFFFFFFF",
    "x5ggbh7x5ggbh7x5ggbh7",
    "1234567887654321",
    "A64KHWZ5WEPAGG",
    "1234567887654321",
    "a64khwz5wepagg",
    "FF0001FF001101FF01023399",
    "XGES63FZZ247C7ZC2ZA6G",
    "FF0001FF001101FF01023399",
    "xges63fzz247c7zc2za6g",
    "25896984125478546598563251452658",
    "2FC28KTA66WRST4XAHRRCF237S8Z",
    "25896984125478546598563251452658",
    "2fc28kta66wrst4xahrrcf237s8z"
  ]

  test "hard coded values" do
    @values
    |> Enum.chunk_every(2)
    |> Enum.each(fn [k, v] ->
      {:ok, bytes} = Base.decode16(k)
      assert String.upcase(v) == Base24.encode24(bytes)
      assert bytes == Base24.decode24(v)
    end)
  end

  test "random values" do
    for size <- 1..4 do
      for _i <- 0..1_000_000 do
        bytes = :crypto.strong_rand_bytes(4 * size)
        a = Base24.encode24(bytes)
        b = Base24.decode24(a)
        assert b == bytes
      end
    end
  end

  test "errors" do
    assert :error == Base24.encode24(<<1, 2, 3>>)
    assert :error == Base24.encode24(<<1, 2, 3, 4, 5>>)
    assert :error == Base24.decode24("1234")
    assert :error == Base24.decode24("ZZZZZZ1")
    assert :error == Base24.decode24("ZZZZZZ")
    assert :error == Base24.decode24("ZZZZZZAA")
  end
end
