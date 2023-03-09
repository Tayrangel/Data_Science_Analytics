--Engenharia Reversa no SQL Power Architect
CREATE TABLE TB_EDITORA (
                cod_editora INT NOT NULL,
                nome_contato VARCHAR(30) NOT NULL,
                telefone_1 VARCHAR(16) NOT NULL,
                telefone_2 VARCHAR(16),
                email VARCHAR(50) NOT NULL,
                PRIMARY KEY (cod_editora)
);


CREATE TABLE TB_LIVRO (
                isbn VARCHAR(20) NOT NULL,
                valor DECIMAL NOT NULL,
                ano_publicacao INT NOT NULL,
                categoria VARCHAR(20) NOT NULL,
                titulo VARCHAR(50) NOT NULL,
                autor VARCHAR(30) NOT NULL,
                cod_editora INT NOT NULL,
                PRIMARY KEY (isbn)
);


CREATE TABLE ESTOQUE (
                isbn VARCHAR(20) NOT NULL,
                qtd_estoque INT NOT NULL,
                PRIMARY KEY (isbn)
);


CREATE TABLE TB_CLIENTE (
                cod_cliente VARCHAR(20) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                telefone_1 VARCHAR(16) NOT NULL,
                telefone_2 VARCHAR(16),
                email VARCHAR(50) NOT NULL,
                rua VARCHAR(50) NOT NULL,
                bairro VARCHAR(30) NOT NULL,
                cidade VARCHAR(30) NOT NULL,
                estado VARCHAR(20) NOT NULL,
                PRIMARY KEY (cod_cliente)
);

ALTER TABLE TB_CLIENTE COMMENT 'tabela entidade cliente';


CREATE TABLE TB_PESSOA_JURIDICA (
                cod_cliente VARCHAR(20) NOT NULL,
                cnpj VARCHAR(15) NOT NULL,
                ie VARCHAR(10) NOT NULL,
                PRIMARY KEY (cod_cliente)
);


CREATE TABLE TB_PESSOA_FISICA (
                cod_cliente VARCHAR(20) NOT NULL,
                cpf VARCHAR(15) NOT NULL,
                rg VARCHAR(15) NOT NULL,
                PRIMARY KEY (cod_cliente)
);


CREATE TABLE TB_PEDIDO (
                cod_pedido VARCHAR(20) NOT NULL,
                data DATE NOT NULL,
                valor_pedido DECIMAL NOT NULL,
                cod_cliente VARCHAR(20) NOT NULL,
                PRIMARY KEY (cod_pedido)
);


CREATE TABLE TB_ITEM_PEDIDO (
                cod_pedido VARCHAR(20) NOT NULL,
                isbn VARCHAR(20) NOT NULL,
                qtd_pedido INT NOT NULL,
                valor_item DECIMAL NOT NULL,
                PRIMARY KEY (cod_pedido, isbn)
);


ALTER TABLE TB_LIVRO ADD CONSTRAINT tb_editora_tb_livro_fk
FOREIGN KEY (cod_editora)
REFERENCES TB_EDITORA (cod_editora)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TB_ITEM_PEDIDO ADD CONSTRAINT tb_livro_tb_item_pedido_fk
FOREIGN KEY (isbn)
REFERENCES TB_LIVRO (isbn)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ESTOQUE ADD CONSTRAINT tb_livro_estoque_fk
FOREIGN KEY (isbn)
REFERENCES TB_LIVRO (isbn)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TB_PEDIDO ADD CONSTRAINT tb_cliente_tb_pedido_fk
FOREIGN KEY (cod_cliente)
REFERENCES TB_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TB_PESSOA_FISICA ADD CONSTRAINT tb_cliente_tb_pessoa_fisica_fk
FOREIGN KEY (cod_cliente)
REFERENCES TB_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TB_PESSOA_JURIDICA ADD CONSTRAINT tb_cliente_tb_pessoa_juridica_fk
FOREIGN KEY (cod_cliente)
REFERENCES TB_CLIENTE (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE TB_ITEM_PEDIDO ADD CONSTRAINT tb_pedido_tb_item_pedido_fk
FOREIGN KEY (cod_pedido)
REFERENCES TB_PEDIDO (cod_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION;