defmodule RadioApi.List do
  @moduledoc false
  require EEx

  defstruct [:items, :previous_url, :next_url]

  EEx.function_from_string(
    :def,
    :to_xml,
    """
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <ListOfItems>
      <ItemCount><%= length(items) %></ItemCount>
      <%= for item <- items do XML.encode(item) end %>
      <%= if next_url do %>
      <Item>
        <ItemType>Dir</ItemType>
        <Title>Next</Title>
        <UrlDir><%= url <> next_url %></UrlDir>
        <UrlDirBackUp><%= url <> next_url %></UrlDirBackUp>
      </Item>
      <% end %>
    </ListOfItems>
    """,
    [:items, :previous_url, :next_url, :url]
  )
end

defimpl XML, for: RadioApi.List do
  @url "http://192.168.1.106"
  def encode(%{items: items, previous_url: previous_url, next_url: next_url}),
    do: RadioApi.List.to_xml(items, previous_url, next_url, @url)
end
