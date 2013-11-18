-module(simple_server).
-export([start_link/2,init/1,rpc/2]).

start_link(Name, Module) ->
	register(Name, spawn(fun() -> loop(Name, Module, Module:init()) end)).

init(Arguments) ->
	Arguments.

rpc(Name, Request) ->
	Name ! {self(),Request},
	receive
		{Name, Response} -> Response
	end.

loop(Name, Module, State) -> 
	receive
		{From, Request} -> 
			{Response,NewState} = Module:handle(Request, State),
			From ! {Name, Response},
			loop(Name, Module, NewState)
	end.
