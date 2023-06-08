# Use an official Elixir runtime as a parent image
FROM elixir:1.14.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy the mix.exs and mix.lock files to the container
COPY mix.exs mix.lock ./

# Install the dependencies
RUN mix do deps.get, deps.compile

# Copy the rest of the application code to the container
COPY . .

# Compile the application
RUN mix compile
RUN mix phx.digest

# Set the environment variable for the Phoenix server
ENV MIX_ENV=prod

# Build the release
RUN mix release

# Use a smaller, Debian-based image for the release
FROM debian:bullseye-slim AS app

# Install the runtime dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libssl1.1 \
    libncurses6 \
    libstdc++6 \
    libgcc-s1 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the release from the build container to the app container
COPY --from=build /app/_build/prod/rel/hello_world .

# Start the Phoenix server
CMD ["bin/hello_world", "start"]
