-module(echo_post_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    PostMsg = case cowboy_http_req:body_qs(<<"echo_post">>, Req) of
        {undefined, _} -> <<"no echo_post querystring parameter">>;
        {X, _} -> X
    end, 
    {ok, Reply} = cowboy_http_req:reply(200, [], ["echo_post: ", PostMsg], Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
