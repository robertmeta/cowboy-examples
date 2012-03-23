-module(upload_html).
-export([init/3, handle/2, terminate/2]).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined_state}.

handle(Req, State) ->
    HtmlContentType = {<<"Content-Type">>, <<"text/html">>},
    {ok, Reply} = cowboy_http_req:reply(200, [HtmlContentType], 
        <<"
        <html><form action='/upload' method='POST'
        enctype='multipart/form-data'>
        <input type='file' name='file'><br>
        <input type='submit'>
        </form></html>
        ">>
    , Req),
    {ok, Reply, State}.

terminate(_Req, _State) ->
    ok.
