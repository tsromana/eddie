%%%
%%% The contents of this file are subject to the Erlang Public License,
%%% Version 1.0, (the "License"); you may not use this file except in
%%% compliance with the License. You may obtain a copy of the License at
%%% http://www.eddieware.org/EPL
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
%%% File    : servant_monitor_sup.erl
%%% Author  : Joakim G. <jocke@erix.ericsson.se>
%%% Created : 24 Jun 1998 by Joakim G. <jocke@erix.ericsson.se>
%%%----------------------------------------------------------------------

-module(servant_monitor_sup).
-author('jocke@erix.ericsson.se').
-vc('$Id: servant_monitor_sup.erl,v 1.1.1.1 2000/10/27 22:20:27 dredd Exp $ ').
-behaviour(supervisor).
-export([start_link/0,init/1]).

%% start_link

start_link() ->
  supervisor:start_link({local,servant_monitor_sup},servant_monitor_sup,[]).

%% init

init(StartArgs) ->
  {ok,{{one_for_one,5,10},[]}}.
