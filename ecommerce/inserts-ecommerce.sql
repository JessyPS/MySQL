select * from ecommerce.cliente;
select * from ecommerce.endereco;
select * from ecommerce.telefone;
select * from ecommerce.pedido;
select * from ecommerce.produto; 
select * from ecommerce.produto_pedido;

insert into ecommerce.produto values (null, '#1515#', 'Harley Davidson', 110000.00, 'Harley Davidson Road King Special, azul', 1, 2019);
insert into ecommerce.pedido (id_cliente, forma_pagamento, status_pedido, data_envio, data_prevista_entrega) values (4, 'cartão de débito', 'em transporte', '2021-09-20', '2021-09-30');

describe ecommerce.cliente;
describe ecommerce.produto;

/* selecionando de outras formas*/
select id, substring(descricao,1,2) from ecommerce.produto where substring(descricao,1,2) = 'Fi';
select id, left (descricao,3) from ecommerce.produto;
select id, right(descricao,3) from ecommerce.produto;
select id, concat(right(descricao,3),left(descricao,3)) from ecommerce.produto;
/*.................................*/

USE ecommerce;
   
select * from cliente
inner join endereco 
on cliente.id = endereco.id_cliente
inner join telefone
on cliente.id = telefone.id_cliente
group by cliente.id;
   
SELECT *
FROM cliente c
JOIN pedido p 
ON c.id = p.id_cliente 
JOIN produto_pedido pp
ON pp.id_pedido = p.id
WHERE pp.id_pedido = 1;
    
select produto.codigo, produto.preco as 'Preço Unitário', 
produto_pedido.quantidade, produto.preco*produto_pedido.quantidade
as Total from produto inner join produto_pedido
on produto_pedido.id_produto = produto.id;

/*FORMATAÇÃO EM REAIS*/
select produto.codigo, produto.preco as 'Preço Unitário', 
produto_pedido.quantidade, concat ('R$ ', format(produto.preco*produto_pedido.quantidade, 2, 'PT-BR'))
as Total from produto inner join produto_pedido
on produto_pedido.id_produto = produto.id;


#LEFT JOIN E RIGHT JOIN    
select cliente.id, cliente.nome from cliente left join pedido
on cliente.id = pedido.id_cliente where pedido.id_cliente = 2;
    
select cliente.id, cliente.nome from cliente right join pedido
on cliente.id = pedido.id_cliente where pedido.id_cliente = 2;
  
        
/*MOSTRAR O CÓDIGO DO PEDIDO E O CÓDIGO DO CLIENTE (3 TABELAS = produto, pedido e produto_pedido)*/
select pedido.id, pedido.id_cliente, produto.nome, produto.preco, produto_pedido.quantidade 
from pedido inner join produto_pedido on pedido.id = produto_pedido.id_pedido 
inner join produto on produto.id = produto_pedido.id_produto;
    
    
/*MOSTRAR O CÓDIGO DO PEDIDO E O CÓDIGO DO CLIENTE - Nome cliente (4 TABELAS = produto, pedido e produto_pedido cliente - 3 inner join)*/
SELECT pedido.id as Pedido, pedido.id_cliente, cliente.nome as Cliente ,
produto.nome AS Produto, produto.preco, produto_pedido.quantidade, produto.preco*produto_pedido.quantidade AS Total
FROM cliente 
INNER JOIN pedido ON cliente.id=pedido.id_cliente 
INNER JOIN produto_pedido ON pedido.id=produto_pedido.id_pedido
INNER JOIN produto ON produto_pedido.id_produto=produto.id
ORDER BY Total, cliente.nome desc; 

SELECT nome from cliente where nome like '%Sou%';
			        
select * from produto pr join pedido p on pr.id = p.id where pr.ano_fab <= 1979 ;
  
#EXERCÍCIO III
    select * from produto where ano_fab between 1970 and 1979;
    select * from produto where preco <= 15000.00 and nome = 'Ford';
    select * from produto where ano_fab between 2000 and 2009 or preco < 12000.00 order by preco; 
    select * from produto where preco < 15000.00 order by preco limit 3;
    select * from produto order by preco desc limit 5;
    
#EXERCÍCIO IV
    update ecommerce.produto set preco = preco*1.1 where nome = 'Harley Davidson';
    select * from produto where nome = 'Harley Davidson';
    update ecommerce.produto set preco = preco/1.08 where nome = 'Ford';
    select * from produto where nome = 'Ford';
    update ecommerce.produto set preco = preco*1.16 where ano_fab between 1970 and 1979;
    select * from produto where ano_fab < 1979;
    
    
    
#Exercícios Aula seguinte (Consultas Avançadas)

#SOMA DE TODOS OS PREÇOS DOS CARROS EM ESTOQUE
#SUM
select sum(preco) as Total from ecommerce.produto;

#SOMA DE TODOS OS PREÇOS DOS CARROS COM ID PAR
select sum(preco) as Total from ecommerce.produto where mod(id,2)=0;
#OU
select sum(preco) as Total from ecommerce.produto where id%2=0;

#MÉDIA DOS PREÇOS DOS CARROS
select avg(preco) as Média from ecommerce.produto;
#OU
select sum(preco)/count(preco) as Média from ecommerce.produto;

#MÉDIA DOS PREÇOS DA MARCA HARLEY DAVIDSON
select avg(preco) as Média from ecommerce.produto where produto.nome = 'Harley Davidson';

#CARRO MAIS BARATO DA DÉCADA DE 70
select * from ecommerce.produto where produto.ano_fab between '1970' and '1979' order by produto.preco limit 1; 

#CARRO MAIS CARO DA DÉCADA DE 70
select * from ecommerce.produto where produto.ano_fab between '1970' and '1979' order by produto.preco desc limit 1;

select produto.nome, count(produto.nome) from ecommerce.produto group by produto.nome;    

#MARCA QUE POSSUI O MAIOR ESTOQUE
select produto.nome, count(*) as Estoque from ecommerce.produto;
SELECT produto.nome, count(*) AS Estoque FROM ecommerce.produto GROUP BY produto.nome 
ORDER BY Estoque DESC;


#quando trabalhamos com group by não podemos utilizar where, neste caso utilizamos having
select produto.nome, count(produto.nome) as Estoque from ecommerce.produto 
group by produto.nome having Estoque = Estoque;

#MAIOR ESTOQUE
select produto.nome, count(produto.nome) as Estoque from ecommerce.produto 
group by produto.nome order by Estoque desc limit 2;

#MARCA QUE POSSUI O MENOR ESTOQUE
select produto.nome, count(produto.nome) as Estoque from ecommerce.produto 
group by produto.nome order by Estoque asc limit 2;


#Veículos Ford
select produto.nome, produto.ano_fab, count(*) as Estoque from ecommerce.produto 
group by produto.nome, produto.ano_fab
having produto.nome = 'Ford' order by produto.ano_fab ;

#Teste
select produto.nome, produto.ano_fab, produto.descricao, count(*) as Estoque from ecommerce.produto 
where produto.descricao like '%4 portas%'
group by produto.nome, produto.ano_fab order by produto.ano_fab;
#having carro.marca = 'Fiat' order by carro.ano ;

