CREATE TABLE Pessoa (
    cpf CHAR(11) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15) NULL
);

CREATE TABLE Paciente (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    senha VARCHAR(20) NOT NULL,
    plano_saude BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT fk_pessoa_paciente
      FOREIGN KEY(cpf_pessoa)
        REFERENCES pessoa(cpf)
);

CREATE TABLE Medico (
    cpf_pessoa CHAR(11) PRIMARY KEY,
    crm VARCHAR(10) UNIQUE NOT NULL,
    CONSTRAINT fk_pessoa_medico
      FOREIGN KEY(cpf_pessoa)
        REFERENCES pessoa(cpf)
);

CREATE TABLE Agendamento(
    cpf_paciente CHAR(11),
    cpf_medico CHAR(11),
    dh_consulta TIMESTAMP,
    dh_agendamento TIMESTAMP NOT NULL,
    valor_consulta FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(cpf_paciente, cpf_medico, dh_consulta),
    CONSTRAINT fk_paciente
      FOREIGN KEY(cpf_paciente)
        REFERENCES paciente(cpf_pessoa),
    CONSTRAINT fk_medico
      FOREIGN KEY(cpf_medico)
        REFERENCES medico(cpf_pessoa)
);

CREATE TABLE Especialidade(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    descricao VARCHAR(300) NOT NULL
);

CREATE TABLE MedicoEspecialidade(
    cpf_medico CHAR(11),
    id_especialidade INT,
    CONSTRAINT pk_medico_especialidade PRIMARY KEY(cpf_medico, id_especialidade),
    CONSTRAINT fk_medico_especialidade
      FOREIGN KEY(cpf_medico)
        REFERENCES medico(cpf_pessoa),
    CONSTRAINT fk_especialidade
      FOREIGN KEY(id_especialidade)
        REFERENCES especialidade(id)
);