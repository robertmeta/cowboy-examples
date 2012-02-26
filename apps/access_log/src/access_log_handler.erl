-module(access_log_handler).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    {ok, Reply} = cowboy_http_req:reply(200, [], <<"Logged this to console">>, Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.

access_log({PeerAddr, DateTime, RequestLine, HttpCode, ContentLength}) ->
    io:format("~s - - [~s] \"~s\" ~p ~p~n", [PeerAddr, DateTime, RequestLine, HttpCode, ContentLength]);
access_log(Req) ->
    {PeerAddr, _} = cowboy_http_req:peer_addr(Req),
    {{Ye,Mo,Da},{Ho,Mi,Se}} = erlang:localtime(),
    DateTime = io_lib:format("~2..0B/~s/~4..0B:~2..0B:~2..0B:~2..0B", [Da,month_as_text(Mo),Ye,Ho,Mi,Se]).

month_as_text(1) -> "jan";
month_as_text(2) -> "feb";
month_as_text(3) -> "mar";
month_as_text(4) -> "apr";
month_as_text(5) -> "may";
month_as_text(6) -> "jun";
month_as_text(7) -> "jul";
month_as_text(8) -> "aug";
month_as_text(9) -> "sep";
month_as_text(10) -> "oct";
month_as_text(11) -> "nov";
month_as_text(12) -> "dec".
