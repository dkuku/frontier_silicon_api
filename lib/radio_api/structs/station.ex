defmodule RadioApi.Station do
  defstruct [
    :id,
    :name,
    :url,
    :logo_url,
    :desc,
    :category
  ]

  require EEx

  EEx.function_from_string(
    :def,
    :to_xml,
    """
    <Item>
     <ItemType>Station</ItemType>
     <StationId><%= id %></StationId>
     <StationName><%= name %></StationName>
     <StationUrl><%= url %></StationUrl>
     <StationDesc><%= desc %></StationDesc>
     <Logo><%= logo_url %></Logo>
     <StationFormat>Radio</StationFormat>
     <StationLocation>Earth</StationLocation>
     <StationBandWidth>32</StationBandWidth>
     <StationMime>MP3</StationMime>
     <Relia>5</Relia>
    </Item>
    """,
    [:id, :name, :url, :logo_url, :desc]
  )
end

defimpl XML, for: RadioApi.Station do
  def encode(station),
    do:
      RadioApi.Station.to_xml(
        station.id,
        station.name,
        station.url,
        station.logo_url,
        station.desc
      )
end
