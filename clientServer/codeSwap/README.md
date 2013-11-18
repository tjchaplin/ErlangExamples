
## Purpose
To demonstrate how server code can be *dynamically* updated without the server being stopped.

## Description

* simple_code_swapping_server.erl - Server to handle code swapping and other requests.  Routes them to callback handlers.
* server_callback.erl - server process to make requests and then respond to callbacks
* server_callback_v2.erl - Upgraded server process to make additioanl requests ontop of server_callback

## Dynamically swap the code

### Step 1 - Run version 1 server

*Spin up a new erlang shell

```
erl
```

* Compile the *code swapping* and *callback* server

```
erlang> c(simple_code_swapping_server).
{ok, simple_code_swapping_server}
erlang> c(server_callback).
{ok, server_callback}
```

* Run the server

```
erlang> simple_code_swapping_server:start_link(server_callback,server_callback).
true
```

* Execute an action
The server_callback we have registered above can now be used to execute a *poke* action

```
erlang> server_callback:poke().
{ok,1}
```

### Step 2 - Swap version 1 for version 2

Now we can use erlang's *dynamic-ness* to swap the existing module for the new module
Note: The step 1 server should still be running.  Use the same erlang shell for the below

* Compile the callback version 2

```
erlang> c(server_callback_v2).
{ok, server_callback_v2}
```

* Swap the code 

```
erlang> simple_code_swapping_server:swap_code(server_callback, server_callback_v2)
```

* And now you can access the new functionality

```
erlang> server_callback_v2:numberOfPokes2().
0
```