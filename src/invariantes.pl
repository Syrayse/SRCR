% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: invariantes.pl                            ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## definir todos os invariantes, tanto referencias co- ##
% ## mo estruturais, de forma a garantir o bom funciona- ##
% ## mento do sistema em questao.                        ##
% #########################################################

% #########################################################
% Definicao de invariantes referencias.
% Invariantes referencias dizem respeito a consistencia
% dos dados, nomeadamente, a evitar a repeticao de conhe-
% cimento, contratos com o mesmo id, etc ...

% 1) Pessoa.

% ---- 1) So pode existir um NIF unico, partilhado entre
% pessoas e empresas.
+pessoa(_,_,_)::(
	solucoes(NIF,
		((pessoa(NIF,_,_) ,
		 empresa(NIF,_,_))),R),
	comprimento(R,0)).

+pessoa(NIF,_,_)::(
	solucoes(NIF,
		(pessoa(NIF,_,_)),R),
	comprimento(R,1)).


% ---- 2) Nao se pode remover uma pessoa se esta tiver
% envolvida em crimes, interdicoes, inabilitacoes, contra-
% tos ou administracoes ou for fiscal.
-pessoa(NIF,_,_)::(
	solucoes(NIF,
		(crime(NIF,_,_);
		 interdito(NIF,_,_);
		 inabilitado(NIF);
		 administrador(NIF,_);
		 contrato(_,NIF,_,_,_,_,_,_,_,_);
		 contrato(_,_,NIF,_,_,_,_,_,_,_);
		 fiscal(NIF)), R),
	comprimento(R,0)).

% 2) Empresa.

% ---- 1) So pode existir um NIF unico, partilhado entre
% pessoas e empresas.
+empresa(NIF,_,_)::(
	solucoes(NIF,
		((pessoa(NIF,_,_) ,
		 empresa(NIF,_,_))),R),
	comprimento(R,0)).

+empresa(NIF,_,_)::(
	solucoes(NIF,
		(empresa(NIF,_,_)),R),
	comprimento(R,1)).

% ---- 2) Nao se pode remover uma empresa se esta tiver
% envolvida em crimes, contratos, administracoes ou rela-
% coes de subempresa.
-empresa(NIF,_,_)::(
	solucoes(NIF,
		(crime(NIF,_,_);
		 administrador(_,NIF);
		 subempresa(NIF,_);
		 subempresa(_,NIF);
		 contrato(_,NIF,_,_,_,_,_,_,_,_);
		 contrato(_,_,NIF,_,_,_,_,_,_,_)), R),
	comprimento(R,0)).

% 3) Crime.

% ---- 1) A entidade acusada de crime deve existir.
+crime(NIF,_,_)::(
	solucoes(NIF,
		(crime(NIF,_,_),
		 (pessoa(NIF,_,_) ;
		  empresa(NIF,_,_))), R),
	comprimento(R,N),
	N >= 1).

% ---- 2) A data de inicio de pena deve ser anterior a data
% de fim da pena.
+crime(_,_,_)::(
	solucoes(NIF,
		( crime(NIF,Di,Df),
		  Di @> Df ), R),
	comprimento(R,0)).

% 4) Interdito.

% ---- 1) A interdicao deve ser emitida para uma pessoa que
% exista.
+interdito(NIF,_,_)::(
	solucoes(NIF,
		(interdito(NIF,_,_) ,
		 pessoa(NIF,_,_)), R),
	comprimento(R,N),
	N >= 1).

% ---- 2) A data de inicio de interdicao deve ser anterior
% a data de fim desta.
+interdito(_,_,_)::(
	solucoes(NIF,
		( interdito(NIF,Di,Df),
		  Di @> Df ), R),
	comprimento(R,0)).

% 5) Inabilitado.

% ---- 1) Deve existir uma pessoa com o NIF de interdicao indi-
% cado, só pode existir uma inabilitacao por pessoa na base
% de conhecimento.
+inabilitado(NIF)::(
	solucoes(NIF,
		(inabilitado(NIF),
		 pessoa(NIF,_,_)),R),
	comprimento(R,1)).

% 6) Administrador.

% ---- 1) A pessoa e empresa devem existir.
+administrador(NIF1,NIF2)::(
	solucoes((NIF1,NIF2),
		(administrador(NIF1,NIF2),
		 pessoa(NIF1,_,_),
		 empresa(NIF2,_,_)),R),
	comprimento(R,1)).

% ---- 2) Nao se deve verificar relacoes de administracao 
% repetidas.

% FEITO EM 6.1)

% 7) Fiscal.

% ---- 1) A pessoa deve existir e nao existir fiscais repe-
% tidos.
+fiscal(NIF)::(
	solucoes(NIF,
		(fiscal(NIF),
		 pessoa(NIF,_,_)),R),
	comprimento(R,1)).

% 7.1) Fiscaliza.

% ---- 1) O fiscal envolvido deve existir.
+fiscaliza(NIF,_,_)::(
	getFiscal(NIF,R),
	comprimento(R,1)).

% ---- 2) O contrato envolvido deve existir, e a data ser
% seguida a data de est. do contrato.
+fiscaliza(_,IDc,_)::(
	solucoes(IDc,
		(fiscaliza(_,IDc,Dt),
		contrato(IDc,_,_,_,_,_,_,_,_,Dc),
		Dc @=< Dt), R),	%>
	comprimento(R,1)).


% 8) Sub-empresa.

% ---- 1) Empresa filha e mae devem existir e nao podem
% ser a mesma.
+subempresa(NIF1,NIF2)::(
	solucoes((NIF1,NIF2),
		( NIF1 =\= NIF2 ,
		  subempresa(NIF1,NIF2),
		  empresa(NIF1,_,_),
		  empresa(NIF2,_,_) ), R),
	comprimento(R,1)).

% 9) Contrato.

% ---- 1) ID de contrato nao pode ser repetido.
+contrato(IDc,_,_,_,_,_,_,_,_,_)::(
	getContrato(IDc, R),
	comprimento(R, 1)).

% ---- 2) Adjudicantes e adjudicatarios devem existir.
+contrato(_,NIF1,NIF2,_,_,_,_,_,_,_)::(
	solucoes((NIF1,NIF2),
		( contrato(_,NIF1,NIF2,_,_,_,_,_,_,_) ,
		  (pessoa(NIF1,_,_) ; empresa(NIF1,_,_)) ,
		  (pessoa(NIF2,_,_) ; empresa(NIF2,_,_)))
		,R),
	comprimento(R,N),
	N >= 1).

% ---- 3) Tipo de contrato e tipo de procedimento deve
%  ser valido.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,_,_,TC,TP,_,_,_,_,_) ,
		  (nao(membro(TC, 
		  		['aquisicao de bens moveis',
		  		 'locacao de bens moveis',
		  		 'aquisicao de servicos',
		  		 'empreitadas de obras publicas'])) ;
		   nao(membro(TP, 
		   		['ajuste direto',
		   		 'consulta previa',
		   		 'concurso publico'])) ) ), R),
	comprimento(R,0)).

% ---- 4) Nao pode ser removido um contrato se este
% tiver em fiscalizacoes.
-contrato(IDc,_,_,_,_,_,_,_,_,_)::(
	solucoes(IDc,
		(fiscaliza(_,IDc,_)), R),
	comprimento(R, 0)).

/*
% #########################################################

% #########################################################
% Definicao de invariantes estruturais.
% Invariantes estruturais dizem respeito a validez dos da-
% dos. Nomeadamente, a garantir que todas as regras do sis-
% tema sao respeitadas, i.e. garantir um numero maximo de
% operacoes, garantia que uma empresa so pode realizar
% contratos se nao possuir parentes criminosos, etc ...

% 1) Pessoa.

% ---- 1) Pessoas apenas podem estar envolvidas num maximo
% de 3 contratos anualmente.

% 2) Empresa.

% ---- NENHUM

% 3) Crime.

% ---- 1) Entidades a cumprir pena nao podem estar envol-
% vidas em contratos.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ,
		  (cumprePena(NIF1, Dt) ;
		   cumprePena(NIF2, Dt) )), R),
	comprimento(R,0)).

% 4) Interdito.

% ---- 1) Pessoas a cumprir interdicao nao podem estar
% envolvidas em contratos.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ,
		  (cumpreInterdicao(NIF1, Dt) ;
		   cumpreInterdicao(NIF2, Dt) )), R),
	comprimento(R,0)).

% ---- 2) Nao podem ser emitidas interdicoes com interva-
% los sobreposto para a mesma pessoa.
+interdicao(NIF,_,_)::(
	solucoes(NIF, 
	 ( interdicao(NIF,Di,Df),
	   interdicao(NIF,Di2, Df2)
	   ,Di =\= Di2, Df =\= Df2,
	   ((Di2 @>= Di, Di2 @=< Df) ;
	    (Df2 @>= Di, Df2 @=< Df)) ), R),
	comprimento(R,0)).

% 5) Inabilitado.

% ---- NENHUM

% 6) Administrador.

% ---- 1) Administrador so pode administrar no maximo 2
% empresas simultaneamente.
+administrador(NIF,_)::(
	getAdministrador(NIF,R),
	comprimento(R,N),
	N =< 2).

% ---- 2) Administrador nao pode ser inabilitado.
+administrador(NIF,_)::(
	getInabilitado(NIF,R),
	comprimento(R,0)).

% ---- 3) Nao pode ser removido administrador caso este
% seja o unico administrador da empresa. 
-administrador(_,NIF2)::(
	getAdministradorEmpresa(NIF2,R),
	comprimento(R,N),
	N >= 1).

% 7) Fiscal.

% ---- 1) Fiscal nao pode ser inabilitado, ter alguma
% vez sido interditato, ou ter registo criminal.
+fiscal(_)::(
	solucoes(NIF, 
		(fiscal(NIF),
		(inabilitado(NIF);
		 interdito(NIF,_,_) ;
		 crime(NIF,_,_))), R),
	comprimento(R,0)).

% 7.1) Fiscaliza.

% ---- 1) Fiscal pode estar envolvido na fiscalizacao
% de no maximo 2 contratos anualmente.

% ---- 2) So pode haver um fiscal responsavel por
% cada contrato.
+fiscaliza(_,_,_)::(
	solucoes(ID,
		(fiscaliza(_,ID,_)), R),
	comprimento(R,1)).

% ---- 3) O fiscal atribuido a um contrato nao pode estar
% diretamente envolvido neste, nem pode ser administrador
% da empresas envolvidas ou respectivas familias.
+fiscaliza(_,_,_)::(
	solucoes(NIF,
		( fiscaliza(NIF,NIFe,_) ,
		  ( administrador(NIF,NIFe) ;
		    (mae(NIFm,NIFe), administrador(NIF,NIFm));
		    (filha(NIFf,NIFe), administrador(NIF,NIFf))) ),R),
	comprimento(R,0)).

% 8) Sub-empresa.

% ---- 1) Empresa filha nao pode ser mae da empresa mae.
%+subempresa(_,_)::(
%	solucoes((NIF1,NIF2),
%		(subempresa(NIF1,NIF2),
%		 mae(NIF1,NIF2)), R),
%	comprimento(R,0)).

% ---- 2) Cada empresa so pode ter uma empresa mae.
%+subempresa(_,_)::(
%	solucoes(NIF, 
%		(subempresa(NIF,NIF1),
%		 subempresa(NIF,NIF2),
%		 NIF1 =\= NIF2),R),
%	comprimento(R,0)).

% 9) Contrato.

% ---- 1) Nenhum ator pode fechar um contrato consigo pro-
% prio.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ),
		  NIF1 =:= NIF2, R),
	comprimento(R,0)).

% ---- 2) Atores nao podem estar a cumprir pena, interditos
% ou inabilitados a data do fecho do contrato.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ,
		  (cumpreInterdicao(NIF1,Dt) ; 
		   cumpreInterdicao(NIF2,Dt) ;
		   inabilitado(NIF1) ;
		   inabilitado(NIF2))), R),
	comprimento(R,0)).

% ---- 3) Nenhum membro da familia de empresas envolvidas
% pode estar a cumprir pena.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ,
		  ((familia(Z,NIF1), cumprePena(Z,Dt)) ;
		   (familia(Z,NIF2), cumprePena(Z,Dt)) )), R),
	comprimento(R,0)).

% ---- 4) Empresas envolvidas com administracoes com regis-
% to criminal nao podem estar envolvidos em contratos.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,_,_,_,_,_,_,Dt) ,
		  ((administrador(Z,NIF1), crime(Z,_,_)) ;
		   (administrador(Z,NIF2), crime(Z,_,_)) )), R),
	comprimento(R,0)).

% ---- 5) Contratos "ajuste direto" devem:
% * possuir valor <= 5.000 euros, * valido para todos os 
% contrato exceto empreitadas de obras publicas, * prazo
% de vigencia maximo de 1 ano.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,_,_,Tc,Tp,_,Val,Pr,_,Dt) ,
		  Tp =:= 'ajuste direto',
		  ((Val < 0 ; Val > 5000) ;
		   (Tc =:= 'empretadas de obras publicas') ;
		   (Pr < 0 ; Pr > 365))  ), R),
	comprimento(R,0)).


% ---- 6) Contratos "consulta previa" devem:
% * possuir valor <= 100.000 euros, * so valido para contra-
% tos de empreitadas de obras publicas, * so podem estar en-
% volvidas empresas, * prazo maximo de 2 anos.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,NIF1,NIF2,Tc,Tp,_,Val,Pr,_,Dt) ,
		  Tp =:= 'ajuste direto',
		  ((Val < 0 ; Val > 100000) ;
		   (Tc =\= 'empretadas de obras publicas') ;
		   (pessoa(NIF1,_,_) ; pessoa(NIF2,_,_)) ;
		   (Pr < 0 ; Pr > 730))  ), R),
	comprimento(R,0)).

% ---- 7) Contratos "concurso publico" devem:
% * possuir valor <= 200.000 euros, * prazo maximo de 5 
% anos.
+contrato(_,_,_,_,_,_,_,_,_,_)::(
	solucoes(ID,
		( contrato(ID,_,_,Tc,Tp,_,Val,Pr,_,Dt) ,
		  Tp =:= 'ajuste direto',
		  ((Val < 0 ; Val > 200000) ;
		   (Pr < 0 ; Pr > 1825))  ), R),
	comprimento(R,0)).

% ---- 8) Regra dos 3 anos: Adjudicante nao pode convidar
% para contrato uma empresa com que tenha celebrado contratos
% com as mesmas prestacoes no ano economico em curso e nos
% dois anos economicos anterior, sempre que a soma dos cont-
% ratos ja celebrados for >= 75.000 euros.

% #########################################################
*/