-module(hello_world_ssl).
-export([start/0, start/2, stop/0]).

start() ->
    application:start(crypto),
    application:start(public_key),
    application:start(ssl),
    application:start(cowboy),
    application:start(hello_world_ssl).

start(_Type, _Args) ->
    Dispatch = [
        {'_', [{'_', hello_world_ssl_handler, []}]}
    ],
    cowboy:start_listener(my_https_listener, 1,
        cowboy_ssl_transport, [
            {port, 8080}, {certfile, "priv/ssl/cert.pem"},
            {keyfile, "priv/ssl/key.pem"}, {password, "cowboy"}],
        cowboy_http_protocol, [{dispatch, Dispatch}]
    ).

stop() ->
    application:stop(cowboy).
