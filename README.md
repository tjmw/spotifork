# Spotifork

## Dependencies

* docker-compose
* docker-machine

## Provision a Machine

```
$ docker-machine create -d <driver> <name>
$ docker-machine active <name>
$ eval "$(docker-machine env <name>)"
```

## Running the app (on a machine)

```
$ docker-compose build
$ docker-compose up -d
```
