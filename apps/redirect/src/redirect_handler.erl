-module(redirect_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {ok, Reply} = cowboy_http_req:reply(
        302,
        [{<<"Location">>, <<"http://www.google.com">>}],
        <<"Redirecting with Header!">>,
        Req
    ),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
