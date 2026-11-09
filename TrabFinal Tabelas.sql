CREATE TABLE IF NOT EXISTS evento
(
  id           SERIAL       NOT NULL,
  nome         varchar(50)  NOT NULL,
  localizacao  varchar(100) NOT NULL,
  qtde_equipes INT          NOT NULL,
  custo        INT8         NOT NULL,
  CONSTRAINT pk_evento PRIMARY KEY (id)
);
CREATE TABLE IF NOT EXISTS jogador
(
  id       SERIAL      NOT NULL,
  nome     varchar(50) NOT NULL,
  email    varchar(50) NOT NULL,
  nickname VARCHAR(50) NOT NULL,
  CONSTRAINT pk_jogador PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS regiao
(
  id   SERIAL      NOT NULL,
  nome VARCHAR(70) NOT NULL,
  CONSTRAINT pk_regiao PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS equipe
(
  id       SERIAL      NOT NULL,
  nome     VARCHAR(50) NOT NULL,
  tag      VARCHAR(10) NULL    ,
  idregiao INT         NOT NULL,
  CONSTRAINT pk_equipe PRIMARY KEY (id),
  CONSTRAINT fk_regiao
    FOREIGN KEY (idregiao)
    REFERENCES regiao (id)
);

CREATE TABLE IF NOT EXISTS fase
(
  id       SERIAL      NOT NULL,
  nome     VARCHAR(50) NOT NULL,
  formato  VARCHAR(50) NOT NULL,
  idevento INT       NOT NULL,

  CONSTRAINT pk_fase PRIMARY KEY (id),
  CONSTRAINT fk_evento
    FOREIGN KEY (idevento)
    REFERENCES evento (id)
);



CREATE TABLE IF NOT EXISTS jogador_equipe
(
  id           SERIAL      NOT NULL,
  data_entrada date        NOT NULL,
  data_saida   date        NULL    ,
  funcao       VARCHAR(50) NOT NULL,
  idjogador    INT         NOT NULL,
  idequipe       INT         NOT NULL,
  CONSTRAINT pk_jogadorequipe PRIMARY KEY (id),
  CONSTRAINT fk_jogador
    FOREIGN KEY (idjogador)
    REFERENCES J=jogador (id),
  CONSTRAINT fk_equipe
    FOREIGN KEY (idequipe)
    REFERENCES equipe (id)
);

CREATE TABLE IF NOT EXISTS partida
(
  id         SERIAL    NOT NULL,
  duracao    int8      NOT NULL,
  hor_inicio TIMESTAMP NOT NULL,
  idfase     INT       NOT NULL,
  CONSTRAINT pk_partida PRIMARY KEY (id),
  CONSTRAINT fk_fase
    FOREIGN KEY (idfase)
    REFERENCES fase (id)
);

CREATE TABLE IF NOT EXISTS partida_equipe
(
  id            SERIAL NOT NULL,
  idpartida    INT NOT NULL,
  idequipe       INT NOT NULL,
  vencedor     BOOL            NOT NULL DEFAULT FALSE,
  abates       INT             NOT NULL DEFAULT 0,
  mortes       INT             NOT NULL DEFAULT 0,
  assistencias INT             NOT NULL DEFAULT 0,
  ouro_total   INT             NOT NULL DEFAULT 0,
  
  CONSTRAINT pk_partidaequipe PRIMARY KEY (id),
  CONSTRAINT fk_partida
    FOREIGN KEY (idpartida)
    REFERENCES partida (id),
  CONSTRAINT fk_equipe
    FOREIGN KEY (idequipe)
    REFERENCES equipe (id)
);

CREATE TABLE IF NOT EXISTS premiacao
(
  id       SERIAL       NOT NULL,
  posicao  int          NOT NULL,
  valor    MONEY NOT NULL,
  idevento INT          NOT NULL,
  idequipe   INT         ,
  CONSTRAINT pk_premiacao PRIMARY KEY (id),
  CONSTRAINT fk_evento
    FOREIGN KEY (idevento)
    REFERENCES evento (id),
  CONSTRAINT fk_equipe
    FOREIGN KEY (idequipe)
    REFERENCES equipe (id)
);



CREATE TABLE IF NOT EXISTS transmissao
(
  id            SERIAL      NOT NULL,
  plataforma    VARCHAR(50) NOT NULL,
  visualizacoes INT8        NOT NULL DEFAULT 0,
  idpartida     INT         NOT NULL,
  CONSTRAINT pk_transmissao PRIMARY KEY (id),
  CONSTRAINT fk_partida
    FOREIGN KEY (idpartida)
    REFERENCES partida (id)
);