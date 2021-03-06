%%%-------------------------------------------------------------------
%%% File:      erlyjs_global_array.erl
%%% @author    Klaus Trainer <klaus_trainer@posteo.de>
%%% @copyright 2013 Klaus Trainer
%%% @doc
%%%
%%% @end
%%%
%%% The MIT License
%%%
%%% Copyright (c) 2012 Klaus Trainer
%%%
%%% Permission is hereby granted, free of charge, to any person obtaining a copy
%%% of this software and associated documentation files (the "Software"), to deal
%%% in the Software without restriction, including without limitation the rights
%%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%%% copies of the Software, and to permit persons to whom the Software is
%%% furnished to do so, subject to the following conditions:
%%%
%%% The above copyright notice and this permission notice shall be included in
%%% all copies or substantial portions of the Software.
%%%
%%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%%% THE SOFTWARE.
%%%
%%% @since 2012-04-13 by Klaus Trainer
%%%-------------------------------------------------------------------
-module(erlyjs_array).
-author('klaus_trainer@posteo.de').

-export([init_new/1, get_length/1, set_length/2]).

-include("erlyjs.hrl").


get_length(ArrayAst) ->
    application(none, atom(length), [ArrayAst]).

set_length(ArrayAst, LengthAst) ->
    CaseArg = get_length(ArrayAst),
    LengthVar = ?gensym("Length"),
    Clauses = [
        clause(
            [LengthVar],
            [infix_expr(LengthVar, operator('>='), LengthAst)],
            [application(atom(lists), atom(sublist), [ArrayAst, LengthAst])]),
        clause(
            [LengthVar],
            [infix_expr(LengthVar, operator('<'), LengthAst)],
            [application(atom(lists), atom(append), [ArrayAst,
                init_new_ast(infix_expr(LengthAst, operator('-'), LengthVar))])])
    ],
    case_expr(CaseArg, Clauses).

init_new(Length) ->
    list(array:to_list(
        array:map(
            fun (_, _) -> atom(undefined) end, array:new(Length)))).

init_new_ast(LengthAst) ->
    application(
        atom(array),
        atom(to_list),
        [
            application(
                atom(array),
                atom(new),
                [LengthAst])
        ]).
