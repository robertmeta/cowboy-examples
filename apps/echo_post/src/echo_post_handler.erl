-module(echo_post_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    echo_postMsg = case cowboy_http_req:qs_val(<<"echo_post">>, Req) of
        {undefined, _} -> <<"no echo_post querystring parameter">>;
        {X, _} -> X
    end, 
    {ok, Reply} = cowboy_http_req:reply(200, [], ["echo_post: ", echo_postMsg], Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
