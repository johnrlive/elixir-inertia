# Threadit

A Reddit-inspired social media platform built with [Phoenix](https://www.phoenixframework.org), [React](https://react.dev) and [Inertia](https://inertiajs.com)

## Running locally

- Install [Elixir and Erlang](https://elixir-lang.org/install.html)
  - I recommend using [asdf](https://asdf-vm.com/) to manage your Elixir and Erlang versions
  - Simply run `asdf install` in the project root to install the correct versions
- Install Postgres (I recommend using [Postgres.app](https://postgresapp.com) on macOS)
- Run `mix setup` to install the elixir dependencies and seed the database
- Install [Node.js](https://nodejs.org/en/download/)
- Install the javascript dependencies with `npm install --prefix assets`
- Start the Phoenix server with `mix phx.server` or inside IEx with `iex -S mix phx.server`
- Now you can visit [`localhost:4000`](http://localhost:4000) from your browser
