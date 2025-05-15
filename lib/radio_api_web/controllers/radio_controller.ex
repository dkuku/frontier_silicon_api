defmodule RadioApiWeb.RadioController do
  use RadioApiWeb, :controller

  def login(conn, %{"token" => "0"}) do
    # when token is "0" the client is unauthenticated
    send_resp(conn, 200, "<EncryptedToken>3a3f5ac48a1dab4e</EncryptedToken>")
  end

  def login(conn, %{"mac" => mac}) do
    # otherwise we have a mac - this means the client is authenticted

    items = items()
    response = XML.encode(items)

    send_resp(conn, 200, response)
  end

  def search(conn, params) do
    items =
      Enum.filter(stations(), fn s -> s.id == params["Search"] end)

    response = XML.encode(%RadioApi.List{items: items, next_url: nil})

    send_resp(conn, 200, response)
  end

  def stations(conn, params) do
    response =
      XML.encode(%RadioApi.List{items: stations(), next_url: nil})

    send_resp(conn, 200, response)
  end

  def podcasts(conn, params) do
    response = XML.encode(%RadioApi.List{items: [], next_url: nil})

    send_resp(conn, 200, response)
  end

  def radio_browser(conn, params) do
    IO.inspect(params, label: :radio_browser)
  end

  def any(conn, params) do
    IO.inspect(params, label: :any)

    send_resp(conn, 200, inspect(params))
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
