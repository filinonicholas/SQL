with Umur as (
SELECT user_id,
case
	when age<20 then '<20 yo'
	when age>=20 and age<30 then '20-29 yo'
	when age>=30 and age<40 then '30-39 yo'
	else '>=40 yo'
	end as Age_Group
  FROM [Finance_Data].[dbo].[User]
)

select b.Age_Group,
	  Format(sum(outstanding_amount),'N')as Total_Outstanding,
	  count(distinct a.user_id) as Total_User_Ever_Loan
from Outstanding a
inner join Umur b 
on a.user_id=b.user_id
group by b.Age_Group
