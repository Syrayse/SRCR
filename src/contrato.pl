%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Contrato
% E todo o comportamento esperado.
% descrito como:
% $ contrato( IdAdte, IdAdria, TipoDeContrato,
%	          TipoDeProc, Desc, Valor,
%             Prazo, Local, Data ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic contrato/9.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Define variaveis globais.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Regras.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes Gerais.

% Todos os contratos possuem:
% 0) Nao permite adicionar contratos repetidos.
% 1) Adjudicante válido.
% 2) Adjudicataria válido.
% 3) Tipo de contrato é uma string.
% 4) Tipo de processo é uma string.
% 5) Descricao é uma string.
% 6) valores de númericos, maiores que 0.
% 7) Prazo numerico, maior que 0.
% 8) Local é uma string.
+contrato(Ae,Ai,Tc,Tp,D,V,P,L,Dt) ::
	(findall(contrato(Ae,Ai,Tc,Tp,D,V,P,L,Dt),
		 contrato(Ae,Ai,Tc,Tp,D,V,P,L,Dt), S),
	 length(S,N), N =< 1,
	 getAdte(Ae,R1), length(R1,1),
	 getAdria(Ai,R2), length(R2,1),
	 membro(Tp, ["ajuste direto",
		     "consulta previa",
		     "concurso publico"]),
	 number(V), V >= 0,
	 number(P), P >= 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Invariantes de Ajuste Direto.


% Contratos por ajuste direto possuem valores iguais
% ou inferiores a 5000. O invariante garante que há
% 0 contratos cujo valor é superior a 5000.
+contrato(_,_,_,"ajuste direto",_,V,_,_,_) ::
	(V =< 5000).

% Contratos de ajuste direto podem ser de três tipos:
% Aquisição de bens móveis, Locação de bens móveis,
% Aquisição de serviços.
+contrato(_,_,Tipo,"ajuste direto",_,_,_,_,_) ::
	(membro(Tipo,["aquisicao de bens moveis",
			"locacao de bens moveis",
			"aquisicao de servicos"])).

% Contratos de ajuste direto possuem um prazo de 1 ano.
+contrato(_,_,_,"ajuste direto",_,_,Prazo,_,_) ::
	(Prazo =< 365, Prazo >= 0).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
getContratos(Ae,R) :-
	findall(
		Ai,
		findall(contrato(Ae,Ai,_,_,_,_,_,_,_)),
		R).