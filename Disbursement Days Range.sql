with filter1 as (
SELECT [user_id]
      ,[disburse_time]
	  ,cast(disburse_time as date) as Tanggal_Dana_Cair
	  ,lag(cast(disburse_time as date))over(partition by user_id order by cast(disburse_time as date) asc) as Tanggal_Before
  FROM [Finance_Data].[dbo].[Disbursement]
)

select *,
Datediff(day,Tanggal_Before,Tanggal_Dana_Cair) as Delta_Hari_Cair
from filter1
where Tanggal_Before is not null
