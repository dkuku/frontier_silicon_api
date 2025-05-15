defmodule RadioApiWeb.RadioController do
  use RadioApiWeb, :controller

  def login(conn, %{"token" => "0"}) do
    # when token is "0" the client is unauthenticated
    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, "<EncryptedToken>3a3f5ac48a1dab4e</EncryptedToken>")
  end

  def login(conn, %{"mac" => mac}) do
    # otherwise we have a mac - this means the client is authenticted

    items = items()
    response = XML.encode(items)

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, response)
  end

  def list(conn, params) do
    IO.inspect(params, label: :list)
  end

  def search(conn, params) do
    IO.inspect(params, label: :search)
    stations(conn, params)

    previous_url =
      "/setupapp/aldi/asp/BrowseXML/loginXML.asp?gofile=&amp;mac=866dbc881b137a0b360928117c37ff9f&amp;dlang=eng&amp;fver=6&amp;ven=targa4"

    items =
      stations()
      |> Enum.filter(fn s -> s.id == params["Search"] end)

    response = XML.encode(%RadioApi.List{items: items, previous_url: previous_url, next_url: nil})
    IO.puts(response)

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, response)
  end

  def stations(conn, params) do
    IO.inspect(params, label: :stations)

    previous_url =
      "/setupapp/aldi/asp/BrowseXML/loginXML.asp?gofile=&amp;mac=866dbc881b137a0b360928117c37ff9f&amp;dlang=eng&amp;fver=6&amp;ven=targa4"

    response =
      XML.encode(%RadioApi.List{items: stations(), previous_url: previous_url, next_url: nil})

    IO.puts(response)

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, response)
  end

  def podcasts(conn, params) do
    IO.inspect(params, label: :podcast)

    previous_url =
      "/setupapp/aldi/asp/BrowseXML/loginXML.asp?gofile=&amp;mac=866dbc881b137a0b360928117c37ff9f&amp;dlang=eng&amp;fver=6&amp;ven=targa4"

    response = XML.encode(%RadioApi.List{items: [], previous_url: previous_url, next_url: nil})

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, response)
  end

  def radio_browser(conn, params) do
    IO.inspect(params, label: :radio_browser)
  end

  def any(conn, params) do
    IO.inspect(params, label: :any)

    conn
    |> send_resp(200, inspect(params))
  end

  def items do
    items = [
      %RadioApi.Dir{
        title: "Podcast",
        path: "/podcast"
      },
      %RadioApi.Dir{
        title: "Radio stations",
        path: "/stations"
      },
      %RadioApi.Dir{
        title: "Radio-Browser",
        path: "/radio-browser?by=none&amp;term=none"
      },
      %RadioApi.Dir{
        title: "GUI-Code: ZNciM",
        path: "/?go=initial"
      }
    ]

    %RadioApi.List{items: items}
  end

  def stations do
    [
      %RadioApi.Station{
        id: "1",
        name: "NDR Info",
        url: "http://www.ndr.de/resources/metadaten/audio/m3u/ndrinfo_sh.m3u",
        logo_url: "http://192.168.1.106/images/radio.jpg",
        desc: "News"
      },
      %RadioApi.Station{
        id: "9617d67b060111e8ae9752543be04c81",
        name: "Antyradio",
        url: "http://n-4-2.dcs.redcdn.pl/sc/o2/Eurozet/live/antyradio.livx?audio=5",
        desc: "metal,rock - Poland",
        logo_url: "http://192.168.1.106/images/radio.jpg"
      }
    ]
  end
end
