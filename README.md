# KeyValue

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## KeyValue Store Project

This project provides a key-value store implemented in Elixir, utilizing Redis as the backend storage. It includes modules for low-level interaction with Redis, high-level operations for setting and getting key-value pairs, and a GraphQL API for querying and mutating key-value pairs.

## Features
- Set and get key-value pairs
- Check if a key exists
- Delete key-value pairs
- GraphQL API for querying and mutating key-value pairs

## Installation
1. Clone the repository:
   ```sh
   git clone <repository_url>
   ```
2. Install dependencies:
   ```sh
   mix deps.get
   ```

## Usage
### Starting the Application
To start the application, run:
```sh
mix run --no-halt
```

### Using the GraphQL API
The GraphQL API is accessible via HTTP. You can use tools like GraphiQL or Postman to interact with it. Here are the endpoints:
- `GET /graphql` (GraphiQL)
- `POST /graphql` (API endpoint)

#### Example Queries/Mutations:
```graphql
# Query a key-value pair
query {
  get_key(key: "example_key") {
    key
    value
  }
}

# Set a key-value pair
mutation {
  set_key(key: "example_key", value: "example_value") {
    key
    value
  }
}
```

## Configuration
The project uses Redis as the backend storage. Make sure Redis is installed and running on `localhost:6379`. You can customize the Redis configuration in `config.exs`.

## Test

```bash
MIX_ENV=test mix test # without coveralls
MIX_ENV=test mix coveralls.html # generate report on cover/excoveralls.html
MIX_ENV=test mix coveralls # run test and show test coverage
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
