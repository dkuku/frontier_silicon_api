# RadioApi

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

For development mode:
make sure your app is available from the outside world
it may require to change the config/dev.exs `http: [ip: {0, 0, 0, 0}, port: 4000]`
then redirect the port 80 to 4000 in your os:
under linux

sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 4000
sudo iptables -t nat -A OUTPUT -p tcp -d localhost --dport 80 -j REDIRECT --to-port 4000

to list your rules
sudo iptables -t nat -L
then add a dns redirect in your dns provider
I'm using openwrt that uses adguard home
