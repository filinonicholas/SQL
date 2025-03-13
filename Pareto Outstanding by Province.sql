with filter1 as (
SELECT a.[user_id]
      ,[user_name]
      ,[age]
      ,[province]
	  ,outstanding_amount
  FROM [Finance_Data].[dbo].[User] a
  inner join [Finance_Data].[dbo].[Outstanding]b
  on a.user_id=b.user_id
  where outstanding_amount>0
),filter2 as(
select  province,
		sum(outstanding_amount) as Jumlah_Outstanding
from filter1
group by province
),filter3 as (
select province,
       Jumlah_Outstanding as Outstanding_Number,
	   sum(Jumlah_Outstanding)over(order by Jumlah_Outstanding desc rows between unbounded preceding and 0 preceding)as Cumulative_Outstanding,
	   cast(0.8*sum(Jumlah_Outstanding)over()as int) as 'Pareto_Total'
from filter2
)

select province, Cumulative_Outstanding,Pareto_Total
from filter3
where Cumulative_Outstanding<=Pareto_Total
