-module(echo_get_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    Reply = case cowboy_http_req:method(Req) of 
        {'GET', _} -> 
            GetMsg = case cowboy_http_req:qs_val(<<"echo_get">>, Req) of
                {undefined, _} -> <<"no echo_get querystring parameter">>;
                {X, _} -> X
            end, 
            {ok, R} = cowboy_http_req:reply(200, [], ["echo_get: ", GetMsg], Req),
            R;
        _ -> 
            {ok, R} = cowboy_http_req:reply(200, [], <<"Not GET'd">>, Req),
            R
    end,
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
