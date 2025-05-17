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

  def search(conn, %{"Search" => uuid} = params) do
    IO.inspect(params)

    uuid
    |> RadioApi.Helpers.UUID.insert_dashes()
    |> RadioBrowser.play()
    |> case do
      [] ->
        IO.inspect(uuid, label: :empty)
        empty_response(conn)

      [station] ->
        response =
          station
          |> RadioApi.StationFull.parse()
          |> XML.encode()

        send_resp(conn, 200, response)
    end
  end

  def stations(conn, params) do
    IO.inspect(params, label: :stations)

    stations =
      "PL"
      |> RadioBrowser.search_by_countrycode()
      |> Enum.map(&RadioApi.Station.parse/1)

    response =
      XML.encode(%RadioApi.List{items: stations, next_url: nil})

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

  def empty_response(conn) do
    response =
      XML.encode(%RadioApi.List{items: [], next_url: nil})

    send_resp(conn, 200, response)
  end
end
