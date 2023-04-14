#Criando schema

CREATE schema CLUBE_DO_LIVRO;

#Criando tabela - Acesse o schema dando duplo clique. Assim, a ação será somente realizada no schema
CREATE table LIVROS (
	id_livro int not null,
    nome_livro varchar(100) not null,
    autoria  varchar(100) not null,
    editora varchar(100) not null,
    categoria varchar(100) not null,
    preço decimal(6,2) not null,
    
    primary key (id_livro)
);

CREATE table ESTOQUE (
	id_livro int not null,
    qtd_estoque int not null,
    
    primary key (id_livro)
);

CREATE table VENDAS (
	id_pedido int not null,
    id_vendedor int not null,
    id_livro int not null,
    qtd_vendida int not null,
    data_venda date not null,
    
    primary key (id_vendedor, id_pedido)
);

CREATE table VENDEDORES (
	id_vendedor int not null,
    nome_vendedor varchar(255) not null,
    
    primary key (id_vendedor)
);

#Alterar tabela adicionando restrição
ALTER table ESTOQUE add constraint ce_estoque_livros
foreign key (id_livro)
references LIVROS (id_livro)
on delete no action
on update no action;

#Inserindo dados, primeiramente é necessario realizar o comando onde as Tabelas não estarão mais relacionadas e a chave estrangeia desativada
SET foreign_key_checks = 0;

INSERT into LIVROS values (
	1,
    "Harry Potter",
    "J.K. Rowlling",
    "Rocco",
    "Ficcção",
    36.99
);

#Inserindo multiplos dados
INSERT into LIVROS values 
(2, "A Volta ao Mundo em 80 Dias", "Júlio Verne", "Principis", "Aventura", 21.99),
(3, "O Cortiço", "Aluísio de Azevedo", "Panda Books", "Romance", 47.8),
(4, "Dom Casmurro", "Machado de Assis", "Via Leitura", "Romance", 19.90),
(5, "Memórias Póstumas de Brás Cubas", "Machado de Assis", "Antofágica", "Romance", 45),
(6, "Quincas Borba", "Machado de Assis", "L&PM Editores", "Romance", 48.5),
(7, "Ícaro", "Gabriel Pedrosa", "Ateliê", "Poesia", 36),
(8, "Os Lusíadas", "Luís Vaz de Camões", "Montecristo", "Poesia", 18.79),
(9, "Outros Jeitos de Usar a Boca", "Rupi Kaur", "Planeta", "Poesia", 34.8);

INSERT into VENDEDORES values 
(1, "Paula Rabelo"),
(2, "Juliana Macedo"),
(3, "Roberto Barros"),
(4, "Barbara Jales");

INSERT INTO VENDAS 
VALUES 
(1, 3, 7, 1, "2020-11-02"),
(2, 4, 8, 2, "2020-11-02"),
(3, 4, 4, 3, "2020-11-02"),
(4, 1, 7, 1, "2020-11-03"),
(5, 1, 6, 3, "2020-11-03"),
(6, 1, 9, 2, "2020-11-04"),
(7, 4, 1, 3, "2020-11-04"),
(8, 1, 5, 2, "2020-11-05"),
(9, 1, 2, 1, "2020-11-05"),
(10, 3, 8, 2, "2020-11-11"),
(11, 1, 1, 4, "2020-11-11"),
(12, 2, 10, 10, "2020-11-11"),
(13, 1, 12, 5, "2020-11-18"),
(14, 2, 4, 1, "2020-11-25"),
(15, 3, 13, 2,"2021-01-05"),
(16, 4, 13, 1, "2021-01-05"),
(17, 4, 4, 3, "2021-01-06"),
(18, 2, 12, 2, "2021-01-06");

INSERT INTO ESTOQUE 
VALUES
(1, 7),
(2, 10),
(3, 2),
(8, 4),
(10, 5),
(11, 3),
(12, 3);

#Realizar a inserção de informações escritas em outra ordem, na ordem das colunas
INSERT into LIVROS
(categoria, autoria, nome_livro, editora, id_livro, preço)
values
("Biografia", "Anne Frank", "Diário de Anne Frank", "Pe da Letra", 12, 34.90);

#Conferindo a inserção dos dados
SELECT * FROM LIVROS;
SELECT NOME_LIVRO FROM LIVROS;
SELECT ID_LIVRO AS "CÓDIGO DO LIVRO" FROM LIVROS;

#Filtrar os dados;
SELECT * FROM LIVROS
WHERE CATEGORIA = "BIOGRAFIA";

#Uma tabela com os romances que custam menos de 48reais
SELECT * FROM LIVROS
WHERE CATEGORIA = "ROMANCE" and PREÇO < 48;

#Um filtro de poesia que não são de Luís Vaz de Camões nem Gabriel Pedrosa
SELECT * FROM LIVROS
WHERE CATEGORIA = "POESIA" and not (AUTORIA = "Luís Vaz de Camões" or AUTORIA = "Gabriel Pedrosa");

#Outros filtros
SELECT distinct id_livro FROM VENDAS
WHERE id_vendedor = 1 
ORDER BY id_livro;

#Deletar um livro
DELETE FROM livros WHERE id_livro = 8;

#Adicionar desconto no preço dos livros. Foi necessario utilizar o comando SET. 
SET sql_safe_updates = 0;
UPDATE livros SET preço = 0.9*preço;

#Filtro entre Tabelas
SELECT vendas.id_vendedor, vendedores.nome_vendedor, vendas.qtd_vendida
FROM VENDAS, VENDEDORES
WHERE vendas.id_vendedor = vendedores.id_vendedor;

SELECT vendas.id_vendedor, vendedores.nome_vendedor, SUM(vendas.qtd_vendida)
FROM VENDAS, VENDEDORES
WHERE vendas.id_vendedor = vendedores.id_vendedor
GROUP BY vendas.id_vendedor;

#Inner Join, Left Join e Right Join
SELECT vendas.id_vendedor, vendedores.nome_vendedor, SUM(vendas.qtd_vendida)
FROM VENDAS INNER JOIN VENDEDORES
ON vendas.id_vendedor = vendedores.id_vendedor
GROUP BY vendas.id_vendedor;

SELECT livros.nome_livro, vendas.qtd_vendida
FROM livros LEFT JOIN vendas
ON livros.id_livro = vendas.id_livro
WHERE vendas.qtd_vendida IS NULL;

SELECT livros.nome_livro, vendas.qtd_vendida, vendas.id_livro
FROM livros RIGHT JOIN vendas
ON livros.id_livro = vendas.id_livro;

