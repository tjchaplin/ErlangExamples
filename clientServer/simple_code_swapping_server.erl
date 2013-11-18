-module(simple_code_swapping_server).
-export([start_link/2,init/1,rpc/2,swap_code/2]).

start_link(Name, Module) ->
	register(Name, spawn(fun() -> loop(Name, Module, Module:init()) end)).

init(Arguments) ->
	Arguments.

swap_code(Name, Module) -> 
	rpc(Name, {swap_code, Module}).

rpc(Name, Request) ->
	Name ! {self(),Request},
	receive
		{Name, Response} -> Response
	end.

loop(Name, Module, State) -> 
	receive
		{From, {swap_code, NewCallBackModule}} ->
			From ! {Name, ack},
			loop(Name, NewCallBackModule, State);
		{From, Request} -> 
			{Response,NewState} = Module:handle(Request, State),
			From ! {Name, Response},
			loop(Name, Module, NewState)
	end.
