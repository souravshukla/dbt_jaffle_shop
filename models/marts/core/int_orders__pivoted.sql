{%-set payment_methods = ['credit_card','coupon','bank_transfer','gift_card']-%}

with payment as
(
    select * from {{ref("stg_payments")}}
),
pivoted as 
(
    select 
        order_id,
        {%for i in payment_methods-%}
            sum(case when payment_method = '{{i}}' then amount else 0 end) as {{i}}_amount {%-if not loop.last-%} , {%endif%}
        {%endfor%}
    from {{ref("stg_payments")}}
    where status = 'success'
    group by order_id
)
select * from pivoted
