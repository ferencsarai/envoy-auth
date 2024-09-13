# Envoy External Authorization

![Envoy Proxy](https://img.shields.io/badge/envoy_proxy-magenta?style=social&logo=envoyproxy&logoSize=auto) ![Docker](https://img.shields.io/badge/docker-blue?style=social&logo=docker&logoSize=auto) ![Ruby](https://img.shields.io/badge/ruby-red?style=social&logo=ruby&logoSize=auto)

This repository demonstrates how to use [Envoy proxy](https://www.envoyproxy.io/) with an external authorization service.

## Install, build and run

To install the project, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/ferencsarai/envoy-auth
    ```

2. Change into the project directory:

    ```bash
    cd envoy-auth
    ```

3. Build the project using Docker Compose:

    ```bash
    docker-compose build
    ```

4. To run the project, use the following command:

    ```bash
    docker-compose up
    ```

## Usage

Once the project is running, you can send requests to `http://localhost:8000` with the `User-Agent: Chrome` header to get a successful response. Requests with any other `User-Agent` header will result in a `403` status code.

- **Not allowed (403)**:

    ```bash
    curl -v -A "sfjs" http://localhost:8000
    ```

- **Allowed (200)** - this will return a response from the echo service [http-echo](https://hub.docker.com/r/solsson/http-echo):

    ```bash
    curl -v -A "Chrome" http://localhost:8000
    ```

## How it works

![Envoy External Authorization](./assets/envoy_proxy.png)

The project utilizes three containers from the docker-compose [file](docker-compose.yaml).

1. [Envoy proxy](Dockerfile-proxy)
2. [External authorization service](Dockerfile-auth-service)
    2.1. [Ruby script](./auth-service.rb)
3. [Service (http-echo)](Dockerfile-web-echo)

## Request flow

1. The client sends a request to Envoy proxy.
2. Envoy proxy forwards the request to the external authorization service.
3. The external authorization service checks the `User-Agent` header.
   - If the `User-Agent` contains `Chrome`, it returns `200`.
   - If the `User-Agent` does not contain `Chrome`, it returns `403`.
4. Envoy proxy forwards the request to the service if `200` is returned. Otherwise, it returns `403` to the client without forwarding the request to the service.

## Configuration

Envoy proxy configuration: [envoy.yaml](./envoy.yaml)
