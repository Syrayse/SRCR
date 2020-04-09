%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Adjucataria
% E todo o comportamento esperado.
% descrito como:
% $ adjudicataria(Nome,NIF,Morada).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic adjudicataria/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Getters e Operações.

% Dado um NIF coloca em R todos os adjudicatarios com esse id.
getAdjudicatario(NIF,R) :-
	solucoes(adjudicataria(NOME,NIF,MORADA),
			 adjudicataria(NOME,NIF,MORADA),
			 R).

% Insere na base de conhecimento um novo adjudicante.
addAdjudicatario(Nome,NIF,Morada) :-
	evolucao(adjudicataria(Nome,NIF,Morada)).

% Remove da base de conhecimento o adjudicante indicado.
remAdjudicatario(Nome,NIF,Morada) :-
	involucao(adjudicataria(Nome,NIF,Morada)).