create table student_hobby (
	id serial primary key,
	student_id int,
	hobby_id int,
	data_start date,
	data_finish date,
	foreign key (student_id) references "student" (id),
	foreign key (hobby_id) references "hobbie" (id)
)
select * from student
select * from hobby
select * from student_hobby
insert into student_hobby (student_id, hobby_id, data_start, data_finish)
values (6, 2, '2013-12-07', null)
insert into student (name, surname, n_group, score, adress, date_birth)
values ('Миронов', 'Павел', 3222, 3.8, 53233, '2002-01-15')

---#1
select name, n_group, score
from student
where score between 4 and 4.5

--#2
select *
from student
where n_group::varchar like '2%'

--#3
--По номеру группы:
select *
from student
order by n_group
--По имени:
select *
from student
order by name

--#4
select *
from student
where score > 4
order by name

--#6
select student_id, hobby_id, data_start, data_finish
from student_hobby
where data_finish is null and data_start between '2018-03-06' and '2021-03-19'

--#7
select *
from student
where score > 4.5
order by score desc

--#8
select *
from student
order by score desc
limit 5

--#9
select risk,
case
when risk >=8 then 'Очень высокий'
when risk >=6 and risk <8 then 'Высокий'
when risk >=4 and risk <8 then 'Средний'
when risk >=2 and risk <4 then 'Низкий'
when risk < 2 then 'Очень низкий' 
end
from hobby

--#10
select name, risk
from hobby
order by risk desc
limit 3

--Групповые
--#1
select count(*), n_group
from student
group by n_group

--#2
select max(score), n_group
from student
group by n_group

--#3
select count(*), surname
from student
group by surname

--#4
select count(*), date_birth
from student
group by date_birth

--#5
select substr(n_group::varchar, 1, 1), avg(score)::real
from student
group by substr(n_group::varchar, 1, 1)

--#6
select substr(n_group::varchar, 1, 1), n_group, max(score)::real
from student
group by substr(n_group::varchar, 1, 1), n_group

--#9
select *
from student
where score in (
	select max(score)
	from student
	where n_group = 3221
) and n_group = 3221

--#10
select *
from student
where score in (
	select max(score) as m_s, n_group
	from student
	group by n_group
)
	
select *
from student s
inner join (
	select max(score) as m_s, n_group
	from student
	group by n_group
) t on s.score = t.m_s and s.n_group = t.n_group

--Многотабличные запросы:
--#1
select s.name, s.surname, h.name
from student s
inner join hobby h on s.id = h.id

--#2
select s.name, s.surname, h.name, data_finish - data_start
from student s
inner join student_hobby sh on s.id = sh.student_id
inner join hobby h on h.id = sh.hobby_id
order by data_finish - data_start desc
limit 1

--#3
select s.name, s.surname, score, 
case
when score >=4.4 then 1
when score < 4.4 then 0 
end
from student s
order by score desc
--inner join student sh on s.id = sh.student_id
--inner join hobby h on h.id = sh.hobby_id

--#4
select s.name, s.surname, s.id, s.date_birth, sh.hobby_id, sh.data_finish - sh.data_start
from student_hobby sh
inner join student s on s.id = sh.student_id

--#5




--#16
select h.id
from hobby h
inner join student_hobby sh


--#18
select id, risk
from hobby
order by risk desc
limit 3

--#19
select s.name, s.surname, sh.data_finish - sh.data_start
from student s
inner join student_hobby sh on sh.student_id = s.id
order by sh.data_finish - sh.data_start desc
limit 10