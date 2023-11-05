with total as 
(
    select sum(amount) as total_amount 
    from {{ref("stg_payments")}}
    where status = 'success'
)
select * from total