% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: ex1.pl                                    ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## fazer a  juncao de todos os diferentes ficheiros de ##
% ## codigo  envolvidos  neste  sistema. Nomeadamente, e ##
% ## incluido cada ficheiro tem  em conta as suas depen- ##
% ## de outos ficheiros.  i.e. 'operacoes.pl' depende de ##
% ## 'base.pl', logo 'base.pl' é incluido primeiro.      ##
% #########################################################

% #########################################################

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

:- op(900,xfy,'::').

% Inclui utensilios base, i.e. evolucao, involucao, ...
:- include('utils.pl').

% Inclui predicados base e respectivo PMF.
:- include('base.pl').

% Inclui operacoes de interesse para com as entidades.
:- include('operacoes.pl').

% #########################################################