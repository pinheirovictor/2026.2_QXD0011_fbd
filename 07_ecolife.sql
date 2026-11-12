-- 1. Tabela Ecoparque
CREATE TABLE Ecoparque (
    id_ecoparque SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    area_total_m2 NUMERIC(10,2),
    data_inauguracao DATE
);

-- 2. Tabela Infraestrutura (1:N com Ecoparque)
CREATE TABLE Infraestrutura (
    id_infraestrutura SERIAL PRIMARY KEY,
    id_ecoparque INT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);

-- 3. Tabela Gestor (1:1 com Ecoparque)
CREATE TABLE Gestor (
    id_gestor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato VARCHAR(100),
    id_ecoparque INT UNIQUE NOT NULL,
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);

-- 4. Tabela Visitante
CREATE TABLE Visitante (
    id_visitante SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    genero VARCHAR(20)
);

-- 5. Tabela Visita (N:N Visitante x Ecoparque)
CREATE TABLE Visita (
    id_visita SERIAL PRIMARY KEY,
    id_visitante INT NOT NULL,
    id_ecoparque INT NOT NULL,
    data_visita DATE NOT NULL,
    avaliacao INT CHECK (avaliacao BETWEEN 1 AND 5),
    FOREIGN KEY (id_visitante) REFERENCES Visitante(id_visitante),
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);

-- 6. Tabela EventoAmbiental
CREATE TABLE EventoAmbiental (
    id_evento SERIAL PRIMARY KEY,
    id_ecoparque INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_evento DATE NOT NULL,
    tipo_evento VARCHAR(50),
    FOREIGN KEY (id_ecoparque) REFERENCES Ecoparque(id_ecoparque)
);

-- 7. Tabela EquipeManutencao
CREATE TABLE EquipeManutencao (
    id_equipe SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

-- 8. Tabela EquipeEvento (N:N EventoAmbiental x EquipeManutencao)
CREATE TABLE EquipeEvento (
    id_evento INT NOT NULL,
    id_equipe INT NOT NULL,
    PRIMARY KEY (id_evento, id_equipe),
    FOREIGN KEY (id_evento) REFERENCES EventoAmbiental(id_evento),
    FOREIGN KEY (id_equipe) REFERENCES EquipeManutencao(id_equipe)
);
