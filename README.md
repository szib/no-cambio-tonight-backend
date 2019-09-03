# No Cambio Tonight Backend

Backend for [No Cambio Tonight](https://github.com/szib/no-cambio-tonight)

## Installation

- Clone repo
- Register an app at [Board Games Atlas](https://www.boardgameatlas.com/api/docs) and get an API key.
- Configure Rails secret credentials as follows:

```yaml
auth:
  secret: <your secret key for generating authentication token>

bga:
  client_id: <your bga client id>
```

- Run

```sh
bundle install
rails db:create
rails db:migrate
rails db:seed # optional
rails s
```
