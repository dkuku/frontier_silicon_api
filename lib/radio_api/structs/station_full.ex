defmodule RadioApi.StationFull do
  @moduledoc """
  used to play the station - should be sent as a single item
  """
  require EEx

  defstruct [
    :id,
    :name,
    :url,
    :logo_url,
    :desc,
    :format,
    :location,
    :bandwidth,
    :mime,
    :reliability
  ]

  EEx.function_from_string(
    :def,
    :to_xml,
    """
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <ListOfItems>
    <ItemCount>1</ItemCount>
    <Item>
     <ItemType>Station</ItemType>
     <StationId><%= id %></StationId>
     <StationName><%= name %></StationName>
     <StationUrl><%= url %></StationUrl>
     <StationDesc><%= desc %></StationDesc>
    <StationFormat><%= format %></StationFormat>
    <StationLocation><%= location %></StationLocation>
    <StationBandWidth><%= bandwidth %></StationBandWidth>
    <StationMime><%= mime %></StationMime>
     <Logo><%= logo_url %></Logo>
    <Relia><%= reliability %></Relia>
    </Item>
    <ListOfItems>
    """,
    [:id, :name, :url, :logo_url, :desc, :format, :location, :bandwidth, :mime, :reliability]
  )

  def parse(%{
        "stationuuid" => id,
        "name" => name,
        "url" => url,
        "favicon" => logo_url,
        "homepage" => desc,
        "country" => country,
        "bitrate" => bitrate,
        "codec" => codec
      }) do
    %RadioApi.StationFull{
      id: id,
      name: name,
      url: url,
      logo_url: logo_url,
      desc: desc,
      format: "Radio",
      location: country,
      bandwidth: bitrate,
      mime: codec,
      reliability: 5
    }
  end
end

defimpl XML, for: RadioApi.StationFull do
  def encode(station),
    do:
      RadioApi.StationFull.to_xml(
        station.id,
        station.name,
        station.url,
        station.logo_url,
        station.desc,
        station.format,
        station.location,
        station.bandwidth,
        station.mime,
        station.reliability
      )
end
