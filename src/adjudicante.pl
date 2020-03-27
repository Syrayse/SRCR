%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Adjudicante
% E todo o comportamento esperado.
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Consultar os utensilios.
:- [utils].

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic adjudicante/3.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Regras.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes.

% Um NIF não pode ser repetido
+adjudicante(_,NIF,_) :-
	(findall( Nome, (adjudicante(Nome,NIF,_)), S),
	length(S,N), N =< 1).