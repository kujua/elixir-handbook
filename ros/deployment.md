**Frontend Kitchen**

iex --name frontend@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server

**Logic**

iex --name logic@127.0.0.1 --erl "-config ../sys.config" -S mix

**Service**

iex --name service@127.0.0.1 --erl "-config ../sys.config" -S mix

**Service API**

iex --name serviceapi@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server


**Testing**

iex --name logic@127.0.0.1 --erl "-config ../sys.config" -S mix
iex --name supervisor@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server
iex --name api@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server
iex --name station@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server
iex --name runner@127.0.0.1 --erl "-config ../sys.config" -S mix phx.server

