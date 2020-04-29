% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: operacoes.pl                              ##
% ## Descricao: O presente ficheiro tem como objetivo  a ##
% ## definicao  de  operacoes  de  interesse do posto de ##
% ## vista de eficiencia  de codigo. Definem-se, tambem, ##
% ## predicados para insercao e  remocao das respectivas ##
% ## entidades, tirando partido dos predicados de evolu- ##
% ## cao e involucao.                                    ##
% #########################################################

% #########################################################
% Operacoes de acesso.

% 0) Data.
% Operacoes para trabalhar com datas.

% ---- 1) Verifica se uma data occore num dado ano.
dataEm(data(YYYY,_,_),YYYY).

% ---- 2) Verifica se uma data esta contida entre o inter-
% valo de anos indicado.
dataEm(data(YYYY,_,_),Y1,Y2) :-
	YYYY >= Y1, YYYY =< Y2.      			% >

% ---- 3) Indica se uma data e anterior a outra data.
menorData(data(Y1,_,_), data(Y2,_,_)) :-
	Y1 =< Y2.                                 % >

menorData(data(Y,M1,_), data(Y,M2,_)) :-
	M1 =< M2.                                % >

menorData(data(Y,M,D1), data(Y,M,D2)) :-
	D1 =< D2.                               % >

% 1) Pessoa.

% ---- 1) Recebe NIF, retorna todas as pessoas associadas
% a este NIF.
getPessoa(NIF,R) :-
	solucoes(pessoa(NIF,_,_), pessoa(NIF,_,_), R).

% 2) Empresa.

% ---- 1) Recebe NIF, retorna todas as empresas associadas
% a este NIF.
getEmpresa(NIF,R) :-
	solucoes(empresa(NIF,_,_), empresa(NIF,_,_), R).

% ---- 2) Recebe NIF, retorna todas os administradores asso-
% ciados a esssa empresa.
getEmpresaAdmins(NIF,R) :-
	solucoes(administrador(Ad,NIF),
			 administrador(Ad,NIF), R).

% ---- 3) Recebe NIF e Data, retorna todos os administrado-
% res associados a essa empresa que estejam a cumprir pena.
getEmpresaAdminsCriminosos(NIF,Data,R) :-
	solucoes(administrador(Ad,NIF),
			(administrador(Ad,NIF),
			 cumprePena(NIF,Data)), R).

% ---- 4) Recebe NIF e Data, retorna todos as empresas com
% esse NIF, que estao de momento a cumprir pena.
getEmpresaCrime(NIF,Data,R) :-
	solucoes(empresa(NIF,_,_),
			(empresa(NIF,_,_),
			 cumprePena(NIF,Data)), R).

% 3) Crime.

% ---- 1) Recebe NIF e data, indica se o NIF indicado esta
% a cumprir pena.
cumprePena(NIF,Data) :-
	crime(NIF, Di, Df), Data @>= Di, Data @=< Df.

% ---- 2) Recebe NIF e Data, indica se o NIF indicado esta
% a cumprir interdicao.
cumpreInterdicao(NIF, Data) :-
	interdito(NIF, Di, Df), Data @>= Di, Data @=< Df.

% ---- 2) Recebe NIF, retorna todas os crimes associados
% a esse NIF.
getCrime(NIF,R) :-
	solucoes(crime(NIF,_,_), crime(NIF,_,_), R).

% ---- 3) Recebe NIF e Data, retorna todas os crimes asso-
% ciados a esse NIF cuja pena engloba a data passada como
% argumento.
getCrimeData(NIF,Data,R) :-
	solucoes( crime(NIF,Di,Df),
			( crime(NIF,Di,Df) , 
			  Data @>= Di,
			  Data @=< Df ), R).

% 4) Interdito.

% ---- 1) Recebe NIF, retorna todas as interdicoes asso-
% ciadas a esse NIF.
getInterdito(NIF,R) :-
	solucoes(interdito(NIF,_,_), interdito(NIF,_,_), R).

% ---- 2) Recebe NIF e Data, retorna todas as interdicoes
% associadas a esse NIF cujo periodo de interdicao engloba
% a data passada como argumento.
getInterditoData(NIF,Data,R) :-
	solucoes( interdito(NIF,Di,Df),
			( interdito(NIF,Di,Df) , 
			  cumpreInterdicao(NIF,Data)), R).

% 5) Inabilitado.

% ---- 1) Recebe NIF, retorna todas os inabilitados asso-
% ciados a esse NIF.
getInabilitado(NIF,R) :-
	solucoes(inabilitado(NIF), inabilitado(NIF), R).

% 6) Administrador.

% ---- 1) Recebe NIF de pessoa, retorna todas os adminis-
% tradores associados a esse NIF.
getAdministrador(NIF,R) :-
	solucoes(administrador(NIF,_), 
			 administrador(NIF,_), R).

% ---- 2) Recebe NIF de empresa, retorna todos os adminis-
% tradores associados a essa empresa.
getAdministradorEmpresa(NIF,R) :-
	solucoes(administrador(_,NIF), 
			 administrador(_,NIF), R).

% ---- 3) Recebe NIF de pessoa e NIF de empresa, retorna 
% todos os casos em que àquela pessoa e administradora
% da empresa indicada.
getAdministradorOverall(NIF1,NIF2,R) :-
	solucoes(administrador(NIF1,NIF2), 
			 administrador(NIF1,NIF2), R).
	
% 7) Fiscal.

% ---- 1) Recebe NIF, retorna todos os fiscais
% associados a esse NIF.
getFiscal(NIF,R) :-
	solucoes(fiscal(NIF), fiscal(NIF), R).

% 7.1) Fiscaliza.

% ---- 1) Recebe NIF, retorna todos as fiscalizacoes
% em que o NIF associado esta a fiscalizar.
getFiscalizacoes(NIF,R) :- 
	solucoes(fiscalizacao(NIF,_,_),
			 fiscalizacao(NIF,_,_), R).

% ---- 2) Recebe ID contrato, retorna todas as fiscali-
% zacoes associadas a esse contrato.
getFiscalizacoesContrato(IDc,R) :-
	solucoes(fiscalizacao(_,IDc,_),
			 fiscalizacao(_,IDc,_), R).

% ---- 3) Recebe NIF do fiscal e ID contrato, retorna 
% todas as fiscalizacoes associadas a esse contrato,
% feitas pelo fiscal indicado.
getFiscalizacoesOverall(NIF,IDc,R) :-
	solucoes(fiscalizacao(NIF,IDc,_),
			 fiscalizacao(NIF,IDc,_), R).

% ---- 4) Recebe ID contrato e data, retorna todas as 
% fiscalizacoes associadas a esse contrato, feitas an-
% teriormente a data indicada como argumento.
getFiscalizacoesData(IDc,Data,R) :-
	solucoes(fiscalizacao(_,IDc,Dt),
			(fiscalizacao(_,IDc,Dt),
			 Dt @< Data), R).

% 8) Sub-empresa.

% ---- 1) Recebe NIF de empresa mae, retorna todas as
% empresas filhas.
getSubempresas(NIF,R) :-
	solucoes(subempresa(NIF,_), subempresa(NIF,_), R).

% ---- 2) Recebe NIF de empresa filha, retorna todas as
% empresas mae.
getMaes(NIF,R) :-
	solucoes(subempresa(_,NIF), subempresa(_,NIF), R).

% ---- 3) Recebe NIF de empresa mae e filha, retorna to-
% das as ocorrencias desta ligacao na base de conhecimento.
getMaes(NIF1,NIF2,R) :-
	solucoes(subempresa(NIF1,NIF2),
			 subempresa(NIF1,NIF2), R).

% ---- 4) Recebe NIF de empresa, e retorna todas as em-
% presas da familia desta.
getEmpresasFamilia(NIF,R) :-
	solucoes(empresa(Z,_,_),
			 ( mae(Z,NIF) ; filha(Z,NIF) ), R).

% ---- 4.1) Verifica se empresa e mae.
mae(X,Y) :- subempresa(Z,X), maeAux(X,Y,Z).

maeAux(X,Y,Y).
maeAux(X,Y,Z) :- 
	subempresa(W,Z), maeAux(X,Y,W). 

% ---- 4.2) Verifica se empresa e filha.
filha(X,Y) :- subempresa(Z,Y), filhaAux(X,Y,Z).

filhaAux(X,Y,X).
filhaAux(X,Y,Z) :-
	subempresa(W,Z), filhaAux(X,Y,W).

% ---- 4.3) Verifica se empresa X e da familia de Y.
familia(X,Y) :- filha(X,Y) ; mae(X,Y).

% ---- 5) Recebe NIF de empresa e data, e retorna todas as 
% empresas da familia desta que estejam a cumprir pena.
getEmpresasFamilia(NIF,Data,R) :-
	solucoes(empresa(Z,_,_),
			 ( (mae(Z,NIF) ; filha(Z,NIF)),
			  cumprePena(NIF,Data) ), R).

% 9) Contrato.

% ---- 1) Recebe ID do contrato, retorna todas os contratos
% com esse id.
getContrato(IDc,R) :-
	solucoes(contrato(IDc,_,_,_,_,_,_,_,_,_,_),
			(contrato(IDc,_,_,_,_,_,_,_,_,_,_)),R).

% ---- 1.1) Recebe ID e versao do contrato, retorna todas os contratos
% com esse id.
getContrato(IDc,V,R) :-
	solucoes(contrato(IDc,V,_,_,_,_,_,_,_,_,_),
			(contrato(IDc,V,_,_,_,_,_,_,_,_,_)),R).

% ---- 2) Recebe um tipo e retorna todos os contratos com
% esse tipo.
getContratoPorTipo(Tipo,R) :-
	solucoes(contrato(_,_,_,_,Tipo,_,_,_,_,_,_),
			(contrato(_,_,_,_,Tipo,_,_,_,_,_,_)),R).

% ---- 3) Recebe ID do contrato, retorna todos os contratos
% com um tipo de procedimento indicado.
getContratoPorProc(Proc,R) :-
	solucoes(contrato(_,_,_,_,_,Proc,_,_,_,_,_),
			(contrato(_,_,_,_,_,Proc,_,_,_,_,_)),R).

% ---- 4) Recebe ID do contrato, retorna todos os contratos
% de um tipo e determinado procedimento.
getContratoOverall(Tipo,Proc,R) :-
	solucoes(contrato(_,_,_,_,Tipo,Proc,_,_,_,_,_),
			(contrato(_,_,_,_,Tipo,Proc,_,_,_,_,_)),R).

% #########################################################

% #########################################################
% Predicados de insercao e remocao de entidades.
% Predicados com o sufixo 'add' sao para insercao.
% Predicados com o sufixo 'rem' sao para remocao.

% 1) Pessoa.
addPessoa( N,No,M ) :-
	evolucao(pessoa( N,No,M )).

remPessoa( N,No,M ) :-
	involucao(pessoa( N,No,M )).

% 2) Empresa.
addEmpresa( N,No,M ) :-
	evolucao(empresa( N,No,M )).

remEmpresa( N,No,M ) :-
	involucao(empresa( N,No,M )).
	

% 3) Crime.
addCrime( N,Di,Df ) :-
	evolucao(crime( N,Di,Df )).

remCrime( N,Di,Df ) :-
	involucao(crime( N,Di,Df )).
	

% 4) Interdito.
addInterdito( N,Di,Df ) :-
	evolucao(interdito( N,Di,Df )).

remInterdito( N,Di,Df ) :-
	involucao(interdito( N,Di,Df )).
	

% 5) Inabilitado.
addInabilitado( N ) :-
	evolucao(inabilitado( N )).

remInabilitado( N ) :-
	involucao(inabilitado( N )).
	

% 6) Administrador.
addAdministrador( Np,Ne ) :-
	evolucao(administrador( Np,Ne )).

remAdministrador( Np,Ne ) :-
	involucao(administrador( Np,Ne )).
	
% 7) Fiscal.
addFiscal( N ) :-
	evolucao(fiscal( N )).

remFiscal( N ) :-
	involucao(fiscal( N )).

% 7.1) Fiscaliza.
addFiscaliza( N,IDc,Df ) :-
	evolucao(fiscaliza( N,IDc,Df )).

remFiscaliza( N,IDc,Df ) :-
	involucao(fiscaliza( N,IDc,Df )).

% 8) Sub-empresa.
addSubempresa( Nm,Nf ) :-
	evolucao(subempresa( Nm,Nf )).

remSubempresa( Nm,Nf ) :-
	involucao(subempresa( Nm,Nf )).

% 9) Contrato.
addContrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt ) :-
	evolucao(contrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt )).

remContrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt ) :-
	involucao(contrato( I1,V1,I2,I3,T1,T2,D,V2,P,L,Dt )).

% #########################################################