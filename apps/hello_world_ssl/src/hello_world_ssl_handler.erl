-module(hello_world_ssl_handler).
-export([init/3, handle/2, terminate/2]).

init({ssl, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {ok, Reply} = cowboy_http_req:reply(200, [], <<"Hello World!">>, Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
