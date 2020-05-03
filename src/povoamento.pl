% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho n  10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: povoamento.pl                             ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## definir fazer um povoamento  inicial da base de co- ##
% ## nhecimento para esta, e  respectivos predicado, po- ##
% ## derem posteriormente ser testados. Fazendo a inser- ##
% ## cao de conhecimento  perfeito e imperfeito adequado ##
% ## ao seu respetivo teste.                             ##
% ##                                                     ##
% ## NIFS 000 -> 099 : pessoas | 100 -> 199 : empresas   ##
% #########################################################

% #########################################################
% Povoamento de conhecimento perfeito.

% 1) Pessoa.

?- addPessoa(001,'Roberto Dias','Rua Calma, n 1').
?- addPessoa(002,'Adolfo Monteiro','Rua Calma, n 2').
?- addPessoa(003,'Rudolfo Monteiro','Rua Calma, n 3').
?- addPessoa(004,'Rudolfo Dias','Rua Calma, n 4').
?- addPessoa(005,'Dominic Torreto','Rua Furiosa, n 10').
?- addPessoa(006,'Pastor Dias','Rua Curiosa, n 5').
?- addPessoa(007,'Luke Skywalker','Tatooine, n 301').
?- addPessoa(008,'Chuck Silva','Rua do Chuck, n 000').
?- addPessoa(009,'Manuel Moreira','Travessa de Cima, n 101').
?- addPessoa(010,'Ric Fazeres', 'Rua do Travesseiro Crocante, n 55').
?- addPessoa(011,'Sr Amares','Rua do Padre').

% 2) Empresa.

?- addEmpresa(100,'Parafusos, lda','Rua Calma, n 1').
?- addEmpresa(101,'Pregos, lda','Rua Calma, n 2').
?- addEmpresa(102,'Tabuas, lda','Rua Calma, n 3').
?- addEmpresa(103,'Areias, lda','Rua Calma, n 4').
?- addEmpresa(104,'Rochas, lda','Rua Calma, n 5').
?- addEmpresa(105,'Zeca Panados', 'Bairro de Santa tecla, n6').
?- addEmpresa(106,'PoBranco, lda', 'Avenida de Amarante, n7').
?- addEmpresa(107,'Maria Bolacha, lda', 'Zona Industral Madeira, n34').
?- addEmpresa(108,'Kebab Turco', 'Avenida Principal, n14').
?- addEmpresa(109,'Seguros, lda', 'Rua do Padre, n34').

% 3) Crime.

% ---- 1) Pessoas.
?- addCrime(007, data(3000,10,10), data(5000,10,10)).
?- addCrime(010, data(2011,07,23), data(2021,08,02)).

% ---- 2) Empresas.
?- addCrime(106, data(1990,12,03), data(2000,12,03)).
?- addCrime(109, data(2008,10,02), data(2015,11,25)).

% 4) Interdito.

?- addInterdito(001, data(1990,10,10), data(2010,10,10)).
?- addInterdito(008, data(2015,08,15), data(2025,09,20)).
?- addInterdito(006, data(2020,09,20), data(2030,10,17)).

% 5) Inabilitado.

?- addInabilitado(005).

% 6) Administrador.

?- addAdministrador(010,104).
?- addAdministrador(009,107).
?- addAdministrador(004,108).

% 7) Fiscal.

?- addFiscal(002).
?- addFiscal(003).

% 8) Sub-empresa.

?- addSubempresa(105, 106).
?- addSubempresa(103, 106).
?- addSubempresa(100, 109).

% 9) Contrato.

?- addContrato(1,1,007,106,'empreitadas de obras publicas',
	        'concurso publico','luke comprou 100g de po',
	        1000, 200, 'Amarante', data(2015,10,10)).

?- addContrato(2,1,001,105,'locacao de bens moveis',
			'ajuste direto','servicos basicos',
			2000, 100, 'Lisboa', data(2011,10,10)).

% 7.1) Fiscaliza.

?- addFiscaliza(002, 1, data(2016,10,10)).
?- addFiscaliza(003, 2, data(2016,10,10)).


% #########################################################

% #########################################################
% Povoamento de conhecimento imperfeito.

% 1) Pessoa.

% CONHECIMENTO INCERTO.

% ---- 1) O Alberto foi inserido no sistema, porem a sua 
% morada e desconhecida.
pessoa(015,'Alberto Dias',morada00).
excecao(pessoa(N,Na,Mo)) :-
	pessoa(N,Na,morada00).

% ---- 2) O Rodolfo foi inserido no sistema, porem a sua 
% morada e desconhecida.
pessoa(016,'Rodolfo Dias',morada01).
excecao(pessoa(N,Na,Mo)) :-
	pessoa(N,Na,morada01).

% ---- 3) Existe uma pessoa em Ermesinde que esta envolvida
% em muitas contratos, porem devido a um erro informatico
% o nome desta pessoa foi perdido, porem sabe-se que o nome
% dessa pessoa certamente nem e 'Pedro' ou 'Rodrigo'.
-pessoa(017,'Pedro','Ermesinde').
-pessoa(017,'Rodrigo','Ermesinde').
pessoa(017,nome00,'Ermesinde').
excecao(pessoa(N,Na,Mo)) :-
	pessoa(N,nome00,Mo).

% CONHECIMENTO IMPRECISO.

% ---- 4) Sabe-se que o Rui possui o NIF 18, porem nao se
% sabe se ele mora na madeira ou em lisboa.
excecao( pessoa(018,'Rui','Madeira') ).
excecao( pessoa(018,'Rui','Lisboa') ).

% ---- 5) Sabe-se que existe uma pessoa com o NIF 19 que mora
% em Barcelos, nao se sabe o nome ao certo. Porem, sabe-se que
% o nome dessa pessoa esta, alfabeticamente, entre 'Filipe' e
% 'Paulo'.
excecao( pessoa(019,Nome01,'Barcelos') ) :-
	Nome01 @>= 'Filipe', Nome01 @=< 'Paulo'.    %>

% ---- 6) Sabe-se que o NIF 20 chama-se 'Pedro' e mora em Lisboa.
% Porem, suspeita-se que na realidade o NIF 20 tenha indicado
% uma identidade falsa, e que na verdade o verdadeiro nome comeca
% com R.
pessoa(020,'Pedro','Lisboa').
excecao( pessoa(020,N,'Lisboa') ) :-
	N @>= 'R', N @< 'S'.

% CONHECIMENTO INTERDITO.

% ---- 7) Sabe-se que existe um individuo com o NIF 21, porem
% esta pessoa usufrui de protecao diplomatica, pelo que o
% seu nome e morada sao totalmente desconhidos, e nunca podem
% ser conhecidos.
pessoa(021,nome02,morada02).
excecao(pessoa(N,Na,Mo)) :-
	pessoa(N,nome02,morada02).

nulo(nome02).
nulo(morada02).

+pessoa(_,_,_)::(
	solucoes((Nome,Morada),
		(pessoa(021,Nome,Morada),
		 nao(nulo(Nome)),
		 nao(nulo(Morada))), R),
	comprimento(R,0)).

% 2) Empresa.

% CONHECIMENTO INCERTO.

% ---- 1) A empresa 'Kebabz' com NIF 122 esta inserida
% num local desconhido, pelo que nao se sabe a sua morada.
% Porem, sabe-se que nao e em Lisboa.
-empresa(122,'Kebabz','Lisboa').
empresa(122,'Kebabz',morada10).
excecao(empresa(N,Na,Mo)) :-
	empresa(N,Na,morada10).

% CONHECIMENTO IMPRECISO.

% ---- 2) Existe uma empresa no Porto com um nome desconhecido
% porem, sabe-se que este nome certamente nao comeca com 'A' ou
% 'B'.
-empresa(123,Nome10,'Porto') :-
	Nome10 @>= 'A', Nome10 @< 'C'.
empresa(123,nome10,'Porto').
excecao( empresa(N,Na,Mo) ) :-
	empresa(N,nome10,Mo).

% CONHECIMENTO INTERDITO.

% ---- 3) Existe uma empresa sediada em Malta, porem, como esta
% sediada num paraiso fiscal, o seu nome e desconhedio. E
% nunca podera vir a ser conhecido.

empresa(124,nome11,'Malta').
excecao(empresa(N,Na,Mo)) :-
	empresa(N,nome11,Mo).

nulo(nome11).

+empresa(_,_,_)::(
	solucoes((Nome,Morada),
		(empresa(124,Nome,'Malta'),
		 nao(nulo(Nome))), R),
	comprimento(R,0)).


% 3) Crime.

% ---- 1) Sabe-se que a data de fim de uma pena, certamente
% nao e superior a sua data de inicio.
-crime(_,data(Y1,_,_),data(Y2,_,_)) :-
	Y1 > Y2.

% CONHECIMENTO INCERTO.

% ---- 2) Sabe-se que a pessoa com o NIF 15 foi condenado em
% 2100-10-10, porem por erro juridico, nao se sabe qual sera
% a data final da pena.
crime(015, data(2100,10,10), data(y0,m0,d0)).
excecao(crime(N,Di,Df)) :-
	crime(N,Di, data(y0,m0,d0)).

% CONHECIMENTO IMPRECISO.

% ---- 3) Sabe-se que a empresa com nif 124 foi condenada
% numa qualquer data entre o ano de 2100 e 2120.
excecao( crime(124,data(Y1,_,_),data(Y2,_,_)) ) :-
	Y1 >= 2100, Y2 =< 2120.             % >

% CONHECIMENTO INTERDITO.

% ---- 4) Sabe-se que a empresa com nif 123 foi condenada
% a prepetua na data de 2200, pelo que devera impossivel indicar
% a data de fim de pena, pois nao existe.

crime(123,data(2200,10,10),data(y1,m1,d1)).
excecao(crime(N,Di,Df)) :-
	crime(N,Di, data(y1,m1,d1)).

nulo(y1).
nulo(m1).
nulo(d1).

+crime(_,_,_)::(
	solucoes((Y,M,D),
		(crime(123,_,data(Y,M,D)),
		 nao(nulo(Y)),
		 nao(nulo(M)),
		 nao(nulo(D)) ), R),
	comprimento(R,0)).

% 4) Interdito.

% NENHUM

% 5) Inabilitado.

% NENHUM

% 6) Administrador.

% NENHUM

% 7) Fiscal.

% NENHUM

% 7.1) Fiscaliza.

% NENHUM

% 8) Sub-empresa.

% NENHUM

% 9) Contrato.

% ---- 1) Contrato confidencial declarado pelo adjudicante
% 006.
contrato(3,1,006,confidencial,'confidencialidade','sigilo','Pastor Dias garante nao divulgar identidade do investidor da sua empresa',10000,18250,'Rua Santa Catarina, Porto',data(2020,04,28)).
excecao(contrato(IDC,V,_,IDA,_,_,_,_,_,_,_)):-
	contrato(IDC,V,_,confidencial,_,_,_,_,_,_,_).
% #########################################################