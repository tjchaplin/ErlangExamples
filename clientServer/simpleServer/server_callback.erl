-module(server_callback).
-export ([poke/0,numberOfPokes/0,init/0,handle/2]).
-import(simple_server,[rpc/2,init/1]).

-record (state, {numberOfPokes = 0}).

init() ->
	init(#state{}).

poke() -> 
	rpc(server_callback,poke).

numberOfPokes() -> 
	rpc(server_callback,numberOfPokes).

handle(poke,State) ->
	NewNumberOfPokes = State#state.numberOfPokes+1,
	NewState = State#state{numberOfPokes=NewNumberOfPokes},
	{NewNumberOfPokes,NewState};

handle(numberOfPokes,State) ->
	NumberOfPokes = State#state.numberOfPokes,
	{NumberOfPokes, State}.