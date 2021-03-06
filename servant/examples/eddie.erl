%%%
%%% The contents of this file are subject to the Erlang Public License,
%%% Version 1.0, (the "License"); you may not use this file except in
%%% compliance with the License. You may obtain a copy of the License at
%%% http://www.eddieware.org/EPL
%%%
%%% The contents of this file are subject to the Erlang Public License
%%% License, Version 1.0, (the "License"); you may not use this file
%%% except in compliance with the License. You may obtain a copy of the
%%% License at http://www.eddieware.org/EPL
%%%
%%% Software distributed under the License is distributed on an "AS IS"
%%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%%% the License for the specific language governing rights and limitations
%%% under the License.
%%%
%%% The Original Code is Eddie-0.83b1.
%%%
%%% The Initial Developer of the Original Code is Ericsson Telecom
%%% AB. Portions created by Ericsson are Copyright (C), 1998, Ericsson
%%% Telecom AB. All Rights Reserved.
%%%
%%% Contributor(s): ______________________________________.
%%%

%%%----------------------------------------------------------------------
%%% File    : eddie.erl
%%% Author  : Joakim G. <jocke@erix.ericsson.se>
%%% Created : 24 Jun 1998 by Joakim G. <jocke@erix.ericsson.se>
%%%----------------------------------------------------------------------

-module(eddie).
-author('jocke@erix.ericsson.se').
-export([start/3,stop/3]).

%% start

start(IPAddress,Port,Profile) ->
  case inet:getaddr(IPAddress,inet) of
    {ok,IP} ->
      case supervisor:start_child(servant_inet_server_sup,
				  {{IP,Port,Profile},
				   {inet_server,start_link,
				    [list_to_atom(Profile),IP]},
				   transient,
				   5000,
				   worker,
				   dynamic}) of
	{ok,Child} ->
	  ok;
	{error,{already_started,OldChild}} ->
	  ok;
	{error,Reason} ->
	  {error,Reason}
      end;
    {error,Reason} ->
      {error,Reason}
  end.

%% stop

stop(IPAddress,Port,Profile) ->
  case inet:getaddr(IPAddress,inet) of
    {ok,IP} ->
      supervisor:terminate_child(servant_inet_server_sup,{IP,Port,Profile}),
      supervisor:delete_child(servant_inet_server_sup,{IP,Port,Profile});
    {error,Reason} ->
      {error,Reason}
  end.
