with filter1 as (
SELECT [user_id]
      ,sum(outstanding_amount) Total_Outstanding
	  ,dense_rank()over(order by sum(outstanding_amount)desc) Ranking_Belum_Bayar
  FROM [Finance_Data].[dbo].[Outstanding]
  group by user_id
)

select *
from filter1
where Ranking_Belum_Bayar between 1 and 10
