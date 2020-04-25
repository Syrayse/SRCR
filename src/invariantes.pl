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

% ---- 2) Nao se pode remover uma pessoa se esta tiver
% envolvida em crimes, interdicoes, inabilitacoes, contra-
% tos ou administracoes.

% 2) Empresa.

% ---- 1) So pode existir um NIF unico, partilhado entre
% pessoas e empresas.

% ---- 2) Nao se pode remover uma empresa se esta tiver
% envolvida em crimes, contratos, administracoes ou rela-
% coes de subempresa.

% 3) Crime.

% ---- 1) A entidade acusada de crime deve existir.

% ---- 2) A data de inicio de pena deve ser anterior a data
% de fim da pena.

% 4) Interdito.

% ---- 1) A interdicao deve ser emitida para uma pessoa que
% exista.

% ---- 2) A data de inicio de interdicao deve ser anterior
% a data de fim desta.

% 5) Inabilitado.

% ---- 1) Deve existir uma pessoa com o NIF de interdicao indi-
% cado, só pode existir uma inabilitacao por pessoa na base
% de conhecimento.

% 6) Administrador.

% ---- 1) A pessoa e empresa devem existir.

% ---- 2) Nao se deve verificar relacoes de administracao 
% repetidas.

% 7) Fiscal.

% ---- 1) A pessoa deve existir e nao existir fiscais repe-
% tidos.

% 7.1) Fiscaliza.

% ---- 1) O fiscal envolvido deve existir.

% ---- 2) O contrato envolvido deve existir, e a data ser
% seguida a data de est. do contrato.

% 8) Sub-empresa.

% ---- 1) Empresa filha e mae devem existir e nao podem
% ser a mesma.

% 9) Contrato.

% ---- 1) ID de contrato nao pode ser repetido.

% ---- 2) Adjudicantes e adjudicatarios devem existir.

% ---- 3) Tipo de contrato e tipo de procedimento deve
%  ser valido.

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

% 4) Interdito.

% ---- 1) Pessoas a cumprir interdicao nao podem estar
% envolvidas em contratos.

% ---- 2) Nao podem ser emitidas interdicoes com interva-
% los sobreposto para a mesma pessoa.

% 5) Inabilitado.

% ---- NENHUM

% 6) Administrador.

% ---- 1) Administrador so pode administrar no maximo 2
% empresas simultaneamente.

% ---- 2) Administrador nao pode ser inabilitado.

% ---- 3) Nao pode ser removido administrador caso este
% seja o unico administrador da empresa. 

% 7) Fiscal.

% ---- 1) Fiscal nao pode ser inabilitado, ter alguma
% vez sido interditato, ou ter registo criminal.

% 7.1) Fiscaliza.

% ---- 1) Fiscal pode estar envolvido na fiscalizacao
% de no maximo 2 contratos anualmente.

% ---- 2) So pode haver um fiscal responsavel por
% cada contrato.

% ---- 3) O fiscal atribuido a um contrato nao pode estar
% diretamente envolvido neste, nem pode ser administrador
% da empresas envolvidas ou respectivas familias.

% 8) Sub-empresa.

% ---- 1) Empresa filha nao pode ser mae da empresa mae.

% ---- 2) Cada empresa so pode ter uma empresa mae.

% 9) Contrato.

% ---- 1) Nenhum ator pode fechar um contrato consigo pro-
% prio.

% ---- 2) Atores nao podem estar a cumprir pena, interditos
% ou inabilitados a data do fecho do contrato.

% ---- 3) Nenhum membro da familia de empresas envolvidas
% pode estar a cumprir pena.

% ---- 4) Empresas envolvidas com administracoes com regis-
% to criminal nao podem estar envolvidos em contratos.

% ---- 5) Contratos "ajuste direto" devem:
% * possuir valor <= 5.000 euros, * valido para todos os 
% contrato exceto empreitadas de obras publicas, * prazo
% de vigencia maximo de 1 ano.

% ---- 6) Contratos "consulta previa" devem:
% * possuir valor <= 100.000 euros, * so valido para contra-
% tos de empreitadas de obras publicas, * so podem estar en-
% volvidas empresas, * prazo maximo de 2 anos.

% ---- 7) Contratos "concurso publico" devem:
% * possuir valor <= 200.000 euros, * prazo maximo de 5 
% anos.

% ---- 8) Regra dos 3 anos: Adjudicante nao pode convidar
% para contrato uma empresa com que tenha celebrado contratos
% com as mesmas prestacoes no ano economico em curso e nos
% dois anos economicos anterior, sempre que a soma dos cont-
% ratos ja celebrados for >= 75.000 euros.

% #########################################################