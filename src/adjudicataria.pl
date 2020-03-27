%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Adjucataria
% E todo o comportamento esperado.
% descrito como:
% $ adjudicataria(Nome,NIF,Morada).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic adjudicataria/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Regras.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes.

% Um NIF não pode ser repetido
+adjudicataria(_,NIF,_) ::
	(findall( Nome, (adjudicataria(Nome,NIF,_)), S),
	length(S,N), N =< 1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

getAdria(NIF,R) :- findall(adjudicataria(N,NIF,M),adjudicataria(N,NIF,M),R).