{% macro limit_data_in_default(column_name)%}
where {{column_name}} > dateadd('year',-6,current_timestamp)
{%endmacro%}