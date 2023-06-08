# HelloWorld

## Build prod image

```bash
docker build -t hello_world .
```

## Run prod container

```bash
docker run -p 4000:4000 -e SECRET_KEY_BASE=`mix phx.gen.secret` hello_world
```

## Run locally in prod

```bash
mix deps.get && mix phx.digest && MIX_ENV=prod SECRET_KEY_BASE=`mix phx.gen.secret` mix phx.server
```

---

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
