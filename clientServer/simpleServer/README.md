
## Purpose
To demonstrate how server code can be used to use callbacks.  This is shows how erlang can be used without using the OTP behaviours.

## Description

* simple_server.erl - Server to handle code swapping and other requests.  Routes them to callback handlers.
* server_callback.erl - server process to make requests and then respond to callbacks

## Call back server

*Spin up a new erlang shell

```
erl
```

* Compile the *server* and *callback* server

```
erlang> c(simple_server).
{ok, simple_server}
erlang> c(server_callback).
{ok, server_callback}
```

* Run the server

```
erlang> simple_server:start_link(server_callback,server_callback).
true
```

* Execute an action
The server_callback we have registered above can now be used to execute a *poke* action

```
erlang> server_callback:poke().
{ok,1}
```