% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
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
% ##                                                     ##
% ## --------------------------------------------------- ##
% ## RESUMO DO POVOAMENTO AQUI CONTIDO:                  ##
% ##       *) 10 Pessoas.                                ##
% ##       *) 10 Empresa.                                ##
% ##       *) 10 Pessoas.                                ##
% ##       *) 10 Pessoas.                                ##
% #########################################################

% #########################################################
% Povoamento de conhecimento perfeito.

% 1) Pessoa.

pessoa(001,'Roberto Dias','Rua Calma, nº 1').
pessoa(002,'Adolfo Monteiro','Rua Calma, nº 2').
pessoa(003,'Rudolfo Monteiro','Rua Calma, nº 3').
pessoa(004,'Rudolfo Dias','Rua Calma, nº 4').
pessoa(005,'Dominic Torreto','Rua Furiosa, nº 10').
pessoa(006,'Pastor Dias','Rua Curiosa, nº 5').
pessoa(007,'Luke Skywalker','Tatooine, nº 301').
pessoa(008,'Chuck Silva','Rua do Chuck, nº 000').
pessoa(009,'Manuel Moreira','Travessa de Cima, nº 101').
pessoa(010,'Ric Fazeres', 'Rua do Travesseiro Crocante, nº 55').

% 2) Empresa.

empresa(100,'Parafusos, lda','Rua Calma, nº 1').
empresa(101,'Pregos, lda','Rua Calma, nº 2').
empresa(102,'Tabuas, lda','Rua Calma, nº 3').
empresa(103,'Areias, lda','Rua Calma, nº 4').
empresa(104,'Rochas, lda','Rua Calma, nº 5').
empresa(105,'Zeca Panados', 'Bairro de Santa tecla, nº6').
empresa(106,'PoBranco, lda', 'Avenida de Amarante, nº7').
empresa(107,'Maria Bolacha, lda', 'Zona Industral Madeira, nº34').
empresa(108,'Kebab Turco', 'Avenida Principal, nº14').
empresa(109,'Seguros, lda', 'Rua do Padre, nº34').

% 3) Crime.

% ---- 1) Pessoas.
crime(007, data(3000,10,10), data(5000,10,10)).
crime(010, data(2011,07,23), data(2021,08,02)).

% ---- 2) Empresas.
crime(106, data(1990,12,03), data(2000,12,03)).
crime(109, data(2008,10,02), data(2015,11,25)).

% 4) Interdito.

interdito(001, data(1990,10,10), data(2010,10,10)).
interdito(008, data(2015,08,15), data(2025,09,20)).
interdito(006, data(2020,09,20), data(2030,10,17)).

% 5) Inabilitado.

inabilitado(005).

% 6) Administrador.

administrador(010,104).
administrador(009,107).
administrador(004,108).

% 7) Fiscal.

fiscal(002).
fiscal(003).

% 7.1) Fiscaliza.

fiscaliza(002, 1, data(2016,10,10)).
fiscaliza(003, 2, data(2021,07,07)).

% 8) Sub-empresa.

subempresa(105, 106).
subempresa(103, 106).
subempresa(100, 109).

% 9) Contrato.

addContrato(1,1,007,106,'empreitadas de obras publicas',
	        'consulta previa','luke comprou 100g de po',
	        1000, 200, 'Amarante', data(2015,10,10)).

addContrato(2,1,002,105,'aquisicao de servicos',
			'ajuste direto','servicos basicos',
			2000, 100, 'Lisboa', data(2020,05,05)).


% #########################################################

% #########################################################
% Povoamento de conhecimento imperfeito.

% 1) Pessoa.

% # Sabemos o NIF destas pessoas, no entanto a sua morada é desconhecida.
excecao(pessoa(010,'Alberto Dias',morada)).
excecao(pessoa(011,'Rodolfo Dias',morada)).

% # Devido ao mau preenchimento de um formulário o NIF ficou como ultimo caracter apagado
excecao(pessoa(n,'Manuel Silva','Rua do Lado, nº 23')) :- n >= 090, n =< 099.

% 2) Empresa.

% # Devido a um erro no sistema algumas empresas viram alguns numeros do NIF apagados
excecao(empresa(n,'Empresa, lda','Rua de Cima, nº 3')) :- n >= 105, n =< 106.
excecao(empresa(n,'Negocios, lda','Rua de Cima, nº 1')) :- n >= 107, n =< 110.
excecao(empresa(n,'Hermanos, lda','Rua de Baixo, nº 3')) :- n >= 111, n =< 115.

% # Devido à falta de organização ninguém sabe ao certo a morada destas empresas
excecao(empresa(116,'Software, lda',morada)).
excecao(empresa(117,'Hardware, lda',morada)).

% 3) Crime.

% # Devido a um erro de cálculo ninguém sabe ao certo quando terminam estes crimes
excecao(crime(1,'2020-02-17',Df)).
excecao(crime(2,'2020-01-10',Df)).
excecao(crime(3,'1994-04-24',Df)).


% 4) Interdito.


% 5) Inabilitado.


% 6) Administrador.


% 7) Fiscal.


% 7.1) Fiscaliza.


% 8) Sub-empresa.


% 9) Contrato.
contrato(1,1,006,confidencial,'confidencialidade','sigilo','Pastor Dias garante nao divulgar identidade do investidor da sua empresa',10000,18250,'Rua Santa Catarina, Porto','2020-04-28').
excecao(contrato(IDC,V,_,IDA,_,_,_,_,_,_,_)):-contrato(IDC,V,_,confidencial,_,_,_,_,_,_,_).
% #########################################################