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
% #########################################################

% #########################################################
% Povoamento de conhecimento perfeito.

% 1) Pessoa.

% # Sabemos o NIF destas pessoas, no entanto a sua morada é desconhecida.
pessoa(001,'Alberto Dias',morada).
pessoa(002,'Rodolfo Dias',morada).

% # Devido ao mau preenchimento de um formulário o NIF ficou como ultimo caracter apagado
excecao(pessoa(n,'Manuel Silva','Rua do Lado, nº 23')) :- n >= 003, n =< 009.

% 2) Empresa.

% # Devido a um erro no sistema algumas empresas viram alguns numeros do NIF apagados
excecao(empresa(n,'Empresa, lda','Rua de Cima, nº 3')) :- n >= 010, n =< 019.
excecao(empresa(n,'Negocios, lda','Rua de Cima, nº 1')) :- n >= 020, n =< 023.
excecao(empresa(n,'Hermanos, lda','Rua de Baixo, nº 3')) :- n >= 024, n =< 029.

% # Devido à falta de organização ninguém sabe ao certo a morada destas empresas
empresa(030,'Software, lda',morada).
empresa(031,'Hardware, lda',morada).
empresa(032,'Martelos, lda',morada).

% 3) Crime.

% # Devido a um erro de cálculo ninguém sabe ao certo quando terminam estes crimes
crime(1,'2020-02-17',Df).
crime(1,'2010-02-17',Df).
crime(2,'2020-01-10',Df).
crime(3,'1994-04-24',Df).


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


% 2) Empresa.


% 3) Crime.


% 4) Interdito.


% 5) Inabilitado.


% 6) Administrador.


% 7) Fiscal.


% 7.1) Fiscaliza.


% 8) Sub-empresa.


% 9) Contrato.


% #########################################################