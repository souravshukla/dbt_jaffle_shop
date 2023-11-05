{% set temp = 45%}

{%if temp > 45%}
    it is hot
{%elif temp < 45%}
    it is cold
{%else%}
    it is normal
{%endif%}

{#
{%- set mylist = ['hello','world','jack'] -%}
{%- for i in mylist -%}
    {{i}}
{%endfor%}

{%- set cool = 'hello' -%}
{{cool}}
#}