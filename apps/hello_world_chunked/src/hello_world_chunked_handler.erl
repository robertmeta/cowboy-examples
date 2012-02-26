-module(hello_world_chunked_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {ok, Reply} = cowboy_http_req:chunked_reply(200, Req),
    cowboy_http_req:chunk("Hello\r\n", Reply),
    timer:sleep(1000),
    cowboy_http_req:chunk("World!", Reply),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
