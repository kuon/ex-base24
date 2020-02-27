defmodule Base24 do
  use Bitwise

  @moduledoc """
  Base24 encoder and decoder.
  """

  defmodule Alphabet do
    @moduledoc false

    @doc false
    def encode_map(alphabet) do
      alphabet
      |> String.to_charlist()
      |> Enum.reduce({%{}, 0}, fn char, {map, idx} ->
        {Map.put(map, idx, char), idx + 1}
      end)
      |> elem(0)
    end

    @doc false
    def decode_map(alphabet) do
      alphabet
      |> String.to_charlist()
      |> Enum.reduce({%{}, 0}, fn char, {map, idx} ->
        [lchar | _] =
          [char]
          |> List.to_string()
          |> String.downcase()
          |> String.to_charlist()

        map =
          map
          |> Map.put(char, idx)
          |> Map.put(lchar, idx)

        {map, idx + 1}
      end)
      |> elem(0)
    end
  end

  @alphabet "ZAC2B3EF4GH5TK67P8RS9WXY"
  @asize byte_size(@alphabet)
  @encode_map Alphabet.encode_map(@alphabet)
  @decode_map Alphabet.decode_map(@alphabet)

  @doc """
  Encode bytes to a String (binary)

  The byte_size() of the string must be a multiple of 4.

  ## Examples

      iex> Base24.encode24(<<0x88, 0x55, 0x33, 0x11>>)
      "5YEATXA"

  """
  @spec encode24(binary()) :: binary() | :error
  def encode24(data) when rem(byte_size(data), 4) != 0, do: :error

  def encode24(data) do
    data
    |> :binary.bin_to_list()
    |> Enum.chunk_every(4)
    |> Enum.reduce([], fn [b0, b1, b2, b3], result ->
      value = b0 <<< 24 ||| b1 <<< 16 ||| b2 <<< 8 ||| b3

      {sub_result, _} =
        Enum.reduce(0..6, {[], value}, fn _, {sub_result, value} ->
          idx = rem(value, @asize)
          value = div(value, @asize)
          char = Map.get(@encode_map, idx)

          {[char | sub_result], value}
        end)

      [result | sub_result]
    end)
    |> to_string
  end

  @doc """
  Decode a String to a binary

  The byte_size() of the string must be a multiple of 7.

  ## Examples

      iex> Base24.decode24("5YEATXA")
      <<0x88, 0x55, 0x33, 0x11>>


  """
  @spec decode24(binary()) :: binary() | :error
  def decode24(data) when rem(byte_size(data), 7) != 0, do: :error

  def decode24(data) do
    try do
      data
      |> :binary.bin_to_list()
      |> Enum.chunk_every(7)
      |> Enum.reduce([], fn chars, result ->
        value =
          Enum.reduce(chars, 0, fn char, value ->
            idx = Map.get(@decode_map, char)
            if idx == nil, do: throw(:invalid_char)
            value * @asize + idx
          end)
        mask = 0xFF
        b0 = (value &&& (mask <<< 24)) >>> 24
        b1 = (value &&& (mask <<< 16)) >>> 16
        b2 = (value &&& (mask <<< 8)) >>> 8
        b3 = value &&& mask

        Enum.concat(result, [b0, b1, b2, b3])
      end)
      |> :binary.list_to_bin
    catch
      :invalid_char -> :error
    end
  end
end

