%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Contrato
% E todo o comportamento esperado.
% descrito como:
% $ contrato( IdAdte, IdAdria, TipoDeContrato,
%	          TipoDeProc, Desc, Valor,
%             Prazo, Local, Data ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Consultar os utensilios.
:- [utils, adjudicante, adjudicataria].

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic contrato/9.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Define variaveis globais.

% Tipos de contratos por ajuste direto.
:- b_setval(
	CtsAjusteDireto, 
	["aquisição de bens móveis",
	 "locação de bens móveis",
	 "aquisição de serviços"]).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Regras.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes Gerais.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes de Ajuste Direto.

% Contratos por ajuste direto possuem valores iguais
% ou inferiores a 5000. O invariante garante que há
% 0 contratos cujo valor é superior a 5000.
+contrato(_,_,_,"ajuste direto",_,Valor,_,_,_) :-
	(Valor =< 5000).

% Contratos de ajuste direto podem ser de três tipos:
% Aquisição de bens móveis, Locação de bens móveis,
% Aquisição de serviços.
+contrato(_,_,Tipo,"ajuste direto",_,_,_,_,_) :-
	(b_getval(CtsAjusteDireto, Cad),
	membro(Tipo,Cad)).

% Contratos de ajuste direto possuem um prazo de 1 ano.
+contrato(_,_,_,"ajuste direto",_,_,Prazo,_,_) :-
	(Prazo =< 365, Prazo >= 0).