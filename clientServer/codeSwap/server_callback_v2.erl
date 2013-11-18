-module(server_callback_v2).
% -export ([poke/0,numberOfPokes/0,kick/0,numberOfKicks/0,init/0,handle/2]).
-export ([poke/0,numberOfPokes/0,numberOfPokes2/0,init/0,handle/2]).
-import(simple_code_swapping_server,[rpc/2,init/1]).

% -record (state, {numberOfPokes = 0,numberOfKicks = 0}).
-record (state, {numberOfPokes = 0}).

init() ->
	init(#state{}).

poke() -> 
	rpc(server_callback,poke).

numberOfPokes() -> 
	rpc(server_callback,numberOfPokes).

numberOfPokes2() -> 
	rpc(server_callback,numberOfPokes2).

% kick() -> 
% 	rpc(server_callback,kick).

% numberOfKicks() -> 
% 	rpc(server_callback,numberOfKicks).

handle(poke,State) ->
	NewNumberOfPokes = State#state.numberOfPokes+1,
	NewState = State#state{numberOfPokes=NewNumberOfPokes},
	{NewNumberOfPokes,NewState};

handle(numberOfPokes,State) ->
	NumberOfPokes = State#state.numberOfPokes,
	{NumberOfPokes, State};

handle(numberOfPokes2,State) ->
	NumberOfPokes = State#state.numberOfPokes,
	{NumberOfPokes, State}.

% handle(kick,State) ->
% 	NewNumberOfKicks = State#state.numberOfKicks+1,
% 	NewState = State#state{numberOfKicks=NewNumberOfKicks},
% 	{NewNumberOfKicks,NewState};

% handle(numberOfKicks,State) ->
% 	NumberOfKicks = State#state.numberOfKicks,
% 	{NumberOfKicks,State}.