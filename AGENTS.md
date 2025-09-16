# AGENTS.md

## Setup

- clone `git clone https://github.com/ferencsarai/envoy-auth.git`
- build `docker-compose build`

## Run

- start `docker-compose up`
- test
  `curl -v -A "sfjs" http://localhost:8000` (not allowed, 403)
  `curl -v -A "Chrome" http://localhost:8000` (allowed, 200)

## CI Testing

Automated tests are defined in [`.github/workflows/ci.yml`](.github/workflows/ci.yml).  
The workflow builds and starts all services using Docker Compose, then performs the following checks:

- Sends a request with `User-Agent: sfjs` to `http://localhost:8000` and expects a `403 Forbidden` response.
- Sends a request with `User-Agent: Chrome` to `http://localhost:8000` and expects a `200 OK` response.

This ensures the authorization logic and proxy routing are working as intended.

## Components

### envoy-proxy

- __id:__ `proxy`
- __description:__  
  Acts as the main entry point for all incoming HTTP requests. Handles routing and delegates authorization to an external service.
- __Dockerfile:__ `docker/envoy-proxy/Dockerfile`
- __Config:__ `docker/envoy-proxy/envoy.yaml`

## auth-service

- __id:__ `auth-srv`
- __description:__  
  A simple Ruby/Sinatra service that checks the `User-Agent` header. Allows requests only if the header contains `Chrome`.
- __Dockerfile:__ `docker/auth-service/Dockerfile`
- __Source:__ `docker/auth-service/auth-service.rb`

## echo-service

- __id:__ `web-echo`
- __description:__  
  An HTTP echo server that returns the incoming request data. Used to demonstrate successful proxying after authorization.
- __Dockerfile:__ `docker/web-echo/Dockerfile`
