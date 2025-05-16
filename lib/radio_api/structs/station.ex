defmodule RadioApi.Station do
  @moduledoc """
  used to display the station on the list of stations
  """
  require EEx

  defstruct [
    :id,
    :name
  ]

  EEx.function_from_string(
    :def,
    :to_xml,
    """
    <Item>
     <ItemType>Station</ItemType>
     <StationId><%= id %></StationId>
     <StationName><%= name %></StationName>
    </Item>
    """,
    [:id, :name]
  )

  def parse(%{"stationuuid" => uuid, "name" => name}) do
    IO.inspect({name, uuid})

    %RadioApi.Station{
      id: RadioApi.Helpers.UUID.strip_dashes(uuid),
      name: name
    }
  end
end

defimpl XML, for: RadioApi.Station do
  def encode(station), do: RadioApi.Station.to_xml(station.id, station.name)
end
