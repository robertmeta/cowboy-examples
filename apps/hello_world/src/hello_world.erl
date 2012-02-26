-module(hello_world).
-export([start/0, stop/0]).

start() ->
    application:start(cowboy),
    Dispatch = [
        {'_', [{'_', hello_world_handler, []}]}
    ],
    cowboy:start_listener(my_http_listener, 3,
        cowboy_tcp_transport, [{port, 8080}],
        cowboy_http_protocol, [{dispatch, Dispatch}]
    ).

stop() ->
    application:stop(cowboy).
