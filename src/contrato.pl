%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro que define a entidade Contrato
% E todo o comportamento esperado.
% descrito como:
% $ contrato( IdCm, IdAdte, IdAdria, TipoDeContrato,
%	          TipoDeProc, Desc, Valor,
%             Prazo, Local, Data ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado é dinâmico.
:- dynamic contrato/10.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Getters e Operações.

% Dado um ID, coloca em R todos os contratos com esse ID.

getContratoID(ID,R) :-
	solucoes(
		(IdAdte,IdAdria),
		(contrato(ID,IdAdte,IdAdria,_,_,_,_,_,_,_)),
		R).

% Dado um contrato, coloca em R contratos desse tipo.

getContratoPorTipo(Tipo,R) :-
	solucoes(
		ID,
		(contrato(ID,_,_,Tipo,_,_,_,_,_,_)),
		R).

% Predicado que dado um tipo de procedimento, coloca em R
% todos os contratos deste tipo com um valor superior a Valor.

getContratoPorProcedimento(Proc,Valor,R) :-
	solucoes(
		ID,
		(contrato(ID,_,_,_,Proc,_,Va,_,_,_),
			Va > Valor),
		R).

% Predicado que dado um tipo de contrato e um tipo de proc.
% coloca em R todos os contratos deste genero, com custo superior a Valor.

getContratoPorTipoEProcedimento(Tipo,Proc,Valor,R) :-
	solucoes(
		ID,
		(contrato(ID,_,_,Tipo,Proc,_,Va,_,_,_),
			Va > Valor),
		R).

% Coloca em R todos os contratos relativos ao adjudicante indicado.

getContratoPorAdjudicante(NIF,R) :-
	solucoes(
		ID,
		(contrato(ID,NIF,_,_,_,_,_,_,_,_)),
		R).

% Coloca em R todos os contratos relativos ao adjudicatario indicado.

getContratoPorAdjudicatario(NIF,R) :-
	solucoes(
		ID,
		(contrato(ID,_,NIF,_,_,_,_,_,_,_)),
		R).

% Coloca em R todos os contratos relativos a um adjudicante, segundo o seu nome.

getContratoPorNome(Nome,R) :-
	solucoes(
		ID,
		(contrato(ID,_,NIF,_,_,_,_,_,_,_),
			adjudicante(NIF,Nome,_)),
		R).

% Coloca em R os contratos feito por todos o adjudicantes que não possuam o nome indicado.

getContratoExcetoNome(Nome,R) :-
	solucoes(
		ID,
		(contrato(ID,_,NIF,_,_,_,_,_,_,_),
			-adjudicante(NIF,Nome,_)),
		R).

% Adiciona um novo contrato

addContrato(IdCm,IdAdte,IdAdria,TipoDeContrato,TipoDeProc, Desc, Valor,Prazo, Local, Data ) :-
	evolucao(contrato(IdCm,IdAdte,IdAdria,TipoDeContrato,TipoDeProc, Desc, Valor,Prazo, Local, Data)).

% Remove um contrato.

remContrato(IdCm,IdAdte,IdAdria,TipoDeContrato,TipoDeProc, Desc, Valor,Prazo, Local, Data ) :-
	involucao(contrato(IdCm,IdAdte,IdAdria,TipoDeContrato,TipoDeProc, Desc, Valor,Prazo, Local, Data)).
