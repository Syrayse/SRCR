%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').


:- include('utils.pl').
:- include('adjudicante.pl').
:- include('adjudicataria.pl').
:- include('contrato.pl').
:- include('povoamento.pl').

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Definição dos Invariantes.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Relativos a Adjudicantes.

% Invariante Nº1
% Um Adjudicante identifica-se pelo seu NIF.

+adjudicante(_,NIF,_) :: (
	getAdjudicante(NIF,R),
	comprimento(R,N), N =< 1).

% Invariante Nº2
% Impossivel remover adjudicantes envolvidos em contratos públicos.

-adjudicante(_,NIF,_) :: (
	getContratoPorAdjudicante(NIF,R),
	comprimento(R,0)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Relativos a Adjudicatarios.

% Invariante Nº1
% Um Adjudicatario identifica-se pelo seu NIF.

+adjudicataria(_,NIF,_) :: (
	getAdjudicatario(NIF,R),
	comprimento(R,N), N =< 1).

% Invariante Nº2
% Impossivel remover ajdudicatarios envolvidos em contratos públicos.

-adjudicataria(_,NIF,_) :: (
	getContratoPorAdjudicatario(NIF,R),
	comprimento(R,0)).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Relativos a Contratos, caracterização dos invariantes no relatorio.

% Invariante Nº1

+contrato(_,Nif1,Nif2,_,_,_,_,_,_,_) :: (
	getAdjudicante(Nif1,R1), comprimento(R1,1),
	getAdjudicatario(Nif2,R2), comprimento(R2,1)).

% Invariante Nº2

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº3

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº4

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº5

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº6

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº7

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº8

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº9

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº10

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº11

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº12

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº13

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº14

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº15

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº16

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº17

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).

% Invariante Nº18

+contrato(_,_,_,_,_,_,_,_,_,_) :: (
	).