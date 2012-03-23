-module(redirect).
-export([start/0, start/2, stop/0]).

start() ->
    application:start(cowboy),
    application:start(redirect).

start(_Type, _Args) ->
    Dispatch = [
        {'_', [{'_', redirect_handler, []}]}
    ],
    cowboy:start_listener(my_http_listener, 1,
        cowboy_tcp_transport, [{port, 8080}],
        cowboy_http_protocol, [{dispatch, Dispatch}]
    ).

stop() ->
    application:stop(cowboy).
