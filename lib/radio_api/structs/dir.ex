defmodule RadioApi.Dir do
  @moduledoc false
  require EEx

  defstruct [:title, :path]

  EEx.function_from_string(
    :def,
    :to_xml,
    """
    <Item>
      <ItemType>Dir</ItemType>
      <Title><%= title %></Title>
      <UrlDir><%= url %></UrlDir>
      <UrlDirBackUp><%= url %></UrlDirBackUp>
    </Item>
    """,
    [:title, :url]
  )
end

defimpl XML, for: RadioApi.Dir do
  @url "http://192.168.1.106"
  def encode(%{title: title, path: path}), do: RadioApi.Dir.to_xml(title, @url <> path)
end
