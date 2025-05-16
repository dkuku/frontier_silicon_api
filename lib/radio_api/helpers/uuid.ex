defmodule RadioApi.Helpers.UUID do
  @moduledoc false

  @doc """
  Strips dashes from a UUID string.

  ## Examples

      iex> RadioApi.Helpers.UUID.strip_dashes("550e8400-e29b-41d4-a716-446655440000")
      "550e8400e29b41d4a716446655440000"
  """
  def strip_dashes(uuid) when is_binary(uuid) do
    String.replace(uuid, "-", "")
  end

  @doc """
  Inserts dashes back into a stripped UUID string.

  ## Examples

      iex> RadioApi.Helpers.UUID.insert_dashes("550e8400e29b41d4a716446655440000")
      "550e8400-e29b-41d4-a716-446655440000"
  """
  def insert_dashes(uuid) when is_binary(uuid) and byte_size(uuid) == 32 do
    <<p1::8-bytes, p2::4-bytes, p3::4-bytes, p4::4-bytes, p5::12-bytes>> = uuid
    "#{p1}-#{p2}-#{p3}-#{p4}-#{p5}"
  end

  def insert_dashes(uuid), do: uuid
end
