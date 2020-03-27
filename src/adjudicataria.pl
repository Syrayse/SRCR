%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Adjucataria
% E todo o comportamento esperado.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Consultar os utensilios.
:- [utils].

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic adjudicataria/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Regras.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes.

% Um NIF não pode ser repetido
+adjudicataria(_,NIF,_) :-
	(findall( Nome, (adjudicataria(Nome,NIF,_)), S),
	length(S,N), N =< 1).