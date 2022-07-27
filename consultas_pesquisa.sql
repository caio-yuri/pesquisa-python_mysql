use pesquisa; -- Selecionando o banco de dados

-- Convertendo data de nascimento em idade
CREATE TEMPORARY TABLE idade
select 
	cod_pessoa,
    genero,
	data_nascimento,
	timestampdiff(YEAR, p.data_nascimento, now()) AS idade
from pessoa AS p;

-- Qual a média de idade dos homens que gostam de chá e clima frio? 
select
	p.genero AS "Gênero",
    avg(idade) AS "Média de Idade"
from idade AS i
join pessoa AS p
	on i.cod_pessoa = p.cod_pessoa
join pesquisa AS pes
	on i.cod_pessoa = pes.cod_pessoa
join bebida AS b
	on pes.cod_bebida = b.cod_bebida
join clima AS c
	on pes.cod_clima = c.cod_clima
where p.genero = "Masculino"  
	AND c.clima = "Frio" 
    AND b.bebida = "Chá" 
group by p.genero;

-- Qual o hobbie de menor preferência entre as mulheres? 
select
	h.hobbie,
    count(pes.cod_hobbie) AS "Qntd"
from pesquisa AS pes
join hobbie AS h
	on pes.cod_hobbie = h.cod_hobbie
join pessoa AS p
	on pes.cod_pessoa = p.cod_pessoa
where p.genero = 'Feminino'
group by h.hobbie
order by 2;

-- Qual o hobbie de maior preferência entre os homens que gostam de cachorro? 
select
	h.hobbie,
    count(pes.cod_hobbie) AS "Qntd"
from pesquisa AS pes
join pessoa AS p
	on pes.cod_pessoa = p.cod_pessoa
join hobbie AS h
	on pes.cod_hobbie = h.cod_hobbie
join animal_estimacao AS a
	on pes.cod_animal_estimacao = a.cod_animal_estimacao
where p.genero = 'Masculino' and a.animal_estimacao = 'Cachorro'
group by h.hobbie
order by 2 DESC;

-- Qual a bebida favorita entre as mulheres e homens, respectivamente? 
select
	p.genero AS "Gênero",
    b.bebida AS "Bebida",
    count(pes.cod_bebida) AS "Qntd"
from pesquisa AS pes
join pessoa AS p
	on pes.cod_pessoa = p.cod_pessoa
join bebida AS b
	on pes.cod_bebida = b.cod_bebida
group by bebida
order by 3 DESC;

-- Qual é a média de idade das pessoas que têm como hobbie Ler livros? 
select
	h.hobbie AS "Hobbie",
    avg(idade) AS "Média de Idade"
from idade AS i
join pesquisa AS pes
	on i.cod_pessoa = pes.cod_pessoa
join hobbie AS h
	on pes.cod_hobbie = h.cod_hobbie
where h.hobbie = "Ler Livros"
group by h.hobbie;

-- Quantas pessoas têm como Hobbie Escrever e qual a sua média de idade, respectivamente? 
select
	count(pes.cod_hobbie) AS 'Qntd de Pessoas',
    avg(idade) AS "Média de Idade"
from idade AS i
join pesquisa AS pes
	on i.cod_pessoa = pes.cod_pessoa
join hobbie AS h
	on pes.cod_hobbie = h.cod_hobbie
where h.hobbie = 'Escrever'
group by h.hobbie;

-- Qual a quantidade de pessoas que gostam de tempo frio? 
select
	c.clima AS "Clima",
    count(pes.cod_clima) AS "Qntd"
from pesquisa AS pes
join clima AS c
	on pes.cod_clima = c.cod_clima
where clima = 'Frio';

-- Qual o animal de estimação preferido entre as mulheres? 
select
	a.animal_estimacao AS "Animal Estimação",
    count(pes.cod_animal_estimacao) AS "Qntd"
from pesquisa AS pes
join animal_estimacao AS a
	on pes.cod_animal_estimacao = a.cod_animal_estimacao
join pessoa AS p
	on pes.cod_pessoa = p.cod_pessoa
where p.genero = 'Feminino'
group by a.animal_estimacao
order by 2 DESC;

-- Quantas pessoas gostam do clima quente por gênero?
select
	p.genero AS "Gênero",
    count(pes.cod_clima) AS "Qntd"
from pesquisa AS pes
join pessoa AS p
	on pes.cod_pessoa = p.cod_pessoa
join clima AS c
	on pes.cod_clima = c.cod_clima
where clima = "Quente"
group by genero
order by 2 DESC;