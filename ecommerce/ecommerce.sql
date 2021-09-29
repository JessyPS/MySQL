create schema if not exists ecommerce;
drop table ecommerce.cliente;
drop table ecommerce.pedido;
drop table ecommerce.produto;
drop table ecommerce.produto_pedido;

create table if not exists ecommerce.cliente(
id int primary key auto_increment,
nome varchar(100) not null,
cpf varchar (14) not null,
email varchar (100) not null,
username varchar (20) not null,
senha varchar(20) not null
);

create table if not exists ecommerce.endereco(
id int primary key auto_increment,
id_cliente int,
foreign key (id_cliente) references cliente (id),
cep varchar (13) not null,
rua varchar (30) not null,
numero int not null,
complemento varchar (30),
bairro varchar (30) not null,
cidade varchar (30) not null,
estado varchar (30) not null
);

create table if not exists ecommerce.telefone(
id int primary key auto_increment,
id_cliente int,
foreign key (id_cliente) references cliente(id),
ddd varchar (4) not null,
numero varchar (10) not null,
tipo varchar (10) not null
);

create table if not exists ecommerce.pedido (
id int primary key auto_increment,
id_cliente int,
foreign key (id_cliente) references cliente(id),
forma_pagamento enum("pix","dinheiro","cartão de crédito","cartão de débito","boleto bancário") not null,
status_pedido varchar (20) not null,
data_envio datetime not null,
data_prevista_entrega datetime not null,
data_entrega_realizada datetime
);

create table if not exists ecommerce.produto (
id int primary key auto_increment,
codigo varchar (50) not null,
nome varchar (60) not null,
preco decimal (8,2) not null,
descricao varchar (500) not null,
qtd_estoque int,
ano_fab varchar (4)
);

create table if not exists ecommerce.produto_pedido (
id_produto int,
id_pedido int,
quantidade int,
primary key (id_produto, id_pedido),
foreign key (id_produto) references produto(id),
foreign key (id_pedido) references pedido(id)
);

alter table ecommerce.telefone change column tipo tipo varchar (20) not null;
alter table ecommerce.produto change column preco preco decimal (10,2) not null;
 