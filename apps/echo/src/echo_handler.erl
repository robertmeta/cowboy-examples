-module(echo_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    EchoMsg = case cowboy_http_req:qs_val(<<"echo">>, Req) of
        {undefined, _} -> <<"no echo querystring parameter">>;
        {X, _} -> X
    end, 
    {ok, Reply} = cowboy_http_req:reply(200, [], ["Echo: ", EchoMsg], Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
