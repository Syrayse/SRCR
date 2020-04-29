% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: base.pl                                   ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## definir todos os predicados  necessarios para o bom ##
% ## funcionamento do sistema, bem como a respectiva ex- ##
% ## tensao destes ao PMF.                               ##
% #########################################################

% #########################################################
% Estabelecimento de predicado dinamicos utilizados.

% 1) Pessoa possui: (NIF, NOME, MORADA).
:- dynamic(pessoa/3).

% 2) Empresa possui: (NIF, NOME, MORADA).
:- dynamic(empresa/3).

% 3) Crime possui: (ID CRIMINOSO, DATA INICIO, DATA FIM).
:- dynamic(crime/3).

% 4) Interdito possui: (NIF, DATA INICIO, DATA FIM).
:- dynamic(interdito/3).

% 5) Inabilitado possui: (NIF).
:- dynamic(inabilitado/1).

% 6) Administrador possui: (NIF Pessoa, NIF Empresa).
:- dynamic(administrador/2).

% 7) Fiscal possui: (NIF).
:- dynamic(fiscal/1).

% 7.1) Fiscal usa predicado fiscaliza, que possui:
% (NIF fiscal, ID contrato, Data de fiscalizacao).
:- dynamic(fiscaliza/3).

% 8) Sub-empresa possui:
% (NIF Empresa Mae, NIF Empresa Filha).
:- dynamic(subempresa/2).

% 9) Contrato possui:
% (ID Contrato, Versao,ID Adjudicante, ID Adjudicatario,
%  TipoDeContrato, TipoDeProc, Descricao, Valor,
%  Prazo, Local, Data ).
:- dynamic(contrato/11).
% #########################################################

% #########################################################
% Extensao dos predicados ao Pressuposto do Mundo Fechado

% 1) Pessoa.
-pessoa( N,No,M ) :-
	nao(pessoa( N,No,M )),
	nao(excecao(pessoa( N,No,M ))).

% 2) Empresa.
-empresa( N,No,M ) :-
	nao(empresa( N,No,M )),
	nao(excecao(empresa( N,No,M ))).

% 3) Crime.
-crime( N,Di,Df ) :-
	nao(crime( N,Di,Df )),
	nao(excecao(crime( N,Di,Df ))).

% 4) Interdito.
-interdito( N,Di,Df ) :-
	nao(interdito( N,Di,Df )),
	nao(excecao(interdito( N,Di,Df ))).

% 5) Inabilitado.
-inabilitado( N ) :-
	nao(inabilitado( N )),
	nao(excecao(inabilitado( N ))).

% 6) Administrador.
-administrador( Np,Ne ) :-
	nao(administrador( Np,Ne )),
	nao(excecao(administrador( Np,Ne ))).

% 7) Fiscal.
-fiscal( N ) :-
	nao(fiscal( N )),
	nao(excecao(fiscal( N ))).

% 7.1) Fiscaliza.
-fiscaliza( N,IDc,Df ) :-
	nao(fiscaliza( N,IDc,Df )),
	nao(excecao(fiscaliza( N,IDc,Df ))).

% 8) Sub-empresa.
-subempresa( Nm,Nf ) :-
	nao(subempresa( Nm,Nf )),
	nao(excecao(subempresa( Nm,Nf ))).

% 9) Contrato.
-contrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt ) :-
	nao(contrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt )),
	nao(excecao(contrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt ))).

% #########################################################