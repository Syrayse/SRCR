%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Ficheiro com definição de predicados úteis.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado que permite a evolucao do conhecimento

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

%--------------------------------- - - - - - - - - - -  -
% Extensão do predicado que permite a involucao do conhecimento

involucao( Termo ) :-
    solucoes( Invariante,-Termo::Invariante,Lista ),
    remocao( Termo ),
    teste( Lista ).

remocao( Termo ) :-
    retract( Termo ).
remocao( Termo ) :-
    assert( Termo ),!,fail.

%--------------------------------- - - - - - - - - - -  -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -
% Extensao do meta-predicado demo: Q, R -> {V,F,D}

demo(Q,verdadeiro) :-
	Q.
demo(Q,falso) :-
	-Q.
demo(Q,desconhecido) :-
	nao(Q),
	nao(-Q).
%--------------------------------- - - - - - - - - - -  -
% Extensao do predicado membro

membro(X,[X|_]) :- !.
membro(X,[_|T]) :- membro(X,T).

%--------------------------------- - - - - - - - - - -  -

solucoes( X,Y,Z ) :-
    findall( X,Y,Z ).

comprimento( S,N ) :-
    length( S,N ).