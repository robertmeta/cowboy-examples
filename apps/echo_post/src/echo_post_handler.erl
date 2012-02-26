-module(echo_post_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    Reply = case cowboy_http_req:method(Req) of 
        {'POST', _} -> 
            PostMsg = case cowboy_http_req:body_qs(Req) of
                {X, _} -> case proplists:get_value(<<"echo_post">>, X) of 
                    undefined -> <<"no echo_post post parameter">>;
                    Y -> Y
                end
            end,
            {ok, R} = cowboy_http_req:reply(200, [], [<<"echo_post: ">>, PostMsg], Req),
            R;
        _ -> 
            {ok, R} = cowboy_http_req:reply(200, [], <<"Not POST'd">>, Req),
            R
    end,
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
