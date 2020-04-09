%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Adjudicante
% E todo o comportamento esperado.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic adjudicante/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Getters e Operações.

% Dado um NIF coloca em R todos os adjudicantes com esse id.
getAdjudicante(NIF,R) :-
	solucoes(adjudicante(NOME,NIF,MORADA),
			 adjudicante(NOME,NIF,MORADA),
			 R).

% Dado um Nome, coloca em R todos os adjudicantes come esse nome.
getAdjudicanteNome(Nome,R) :-
	solucoes(adjudicante(Nome,NIF,MORADA),
			 adjudicante(Nome,NIF,MORADA),
			 R).

% Insere na base de conhecimento um novo adjudicante.
addAdjudicante(Nome,NIF,Morada) :-
	evolucao(adjudicante(Nome,NIF,Morada)).

% Remove da base de conhecimento o adjudicante indicado.
remAdjudicante(Nome,NIF,Morada) :-
	involucao(adjudicante(Nome,NIF,Morada)).