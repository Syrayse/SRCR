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
% ## 						                             ##
% ## NIFS 000 -> 099 : pessoas | 100 -> 199 : empresas   ##
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


% 2) Empresa.

empresa(100,'Parafusos, lda','Rua Calma, nº 1').
empresa(101,'Pregos, lda','Rua Calma, nº 2').
empresa(102,'Tabuas, lda','Rua Calma, nº 3').
empresa(103,'Areias, lda','Rua Calma, nº 4').
empresa(104,'Rochas, lda','Rua Calma, nº 5').

% 3) Crime.



% 4) Interdito.


% 5) Inabilitado.


% 6) Administrador.


% 7) Fiscal.


% 7.1) Fiscaliza.


% 8) Sub-empresa.


% 9) Contrato.


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
excecao(empresa(118,'Martelos, lda',morada)).

% 3) Crime.

% # Devido a um erro de cálculo ninguém sabe ao certo quando terminam estes crimes
excecao(crime(1,'2020-02-17',Df)).
excecao(crime(1,'2010-02-17',Df)).
excecao(crime(2,'2020-01-10',Df)).
excecao(crime(3,'1994-04-24',Df)).


% 4) Interdito.


% 5) Inabilitado.


% 6) Administrador.


% 7) Fiscal.


% 7.1) Fiscaliza.


% 8) Sub-empresa.


% 9) Contrato.


% #########################################################