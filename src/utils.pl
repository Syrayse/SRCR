% #########################################################
% ## SRCR - Dominio de Contratacao Publica.              ##
% ## Desenvolvido pelo grupo de trabalho nº 10.          ##
% ## Ano letivo 2019/20 - MIEI.                          ##
% ##                                                     ##
% ## --------------------------------------------------- ##
% ##                                                     ##
% ## Ficheiro: utils.pl                                  ##
% ## Descricao: O presente ficheiro  tem o  objetivo  de ##
% ## definir predicados de interesse do ponto de vista   ##
% ## funcional para o sistema.                           ##
% #########################################################

% #########################################################
% 1) Evolucao de conhecimento.

evolucao( Termo ) :-
    solucoes( Invariante, +Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ). 

insercao( Termo ) :-
    assert( Termo ).
insercao( Termo ) :-
    retract( Termo ), !,fail.
	
teste( [] ).
teste( [R|LR] ) :-
    R,
    teste( LR ).

% #########################################################

% #########################################################
% 2) Involucao de conhecimento.

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

% #########################################################

% #########################################################
% 3) Predicados de extensao de logica.

% 3.1) Extensao do meta-predicado nao: Questao -> {V,F}.

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

% 3.2) Extensao do meta-predicado demo: Q, R -> {V,F,D}.

demo(Q,verdadeiro) :-
    Q.
demo(Q,falso) :-
    -Q.
demo(Q,desconhecido) :-
    nao(Q),
    nao(-Q).

% #########################################################

% #########################################################
% 4) Outros predicados de interesse.

% 4.1) Teste de pertence de elemento a lista.

membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

% 4.2) Wrapper do predicado findall.

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

% 4.3) Wrapper do predicado comprimento.

comprimento( S,N ) :-
    length( S,N ).

% #########################################################