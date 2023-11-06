{% macro clean_slate_models(database = target.database, schema = target.schema, day = 7, dry_run = True)%}
    {%set clean_query%}
        select 
            case when table_type = 'VIEW' then table_type else 'TABLE' end as drop_type,
            'DROP' || drop_type || '{{database | upper}}.' || TABLE_SCHEMA || '.' || TABLE_NAME||';' as drop_query
        from {{database}}.information_schema.tables
        where TABLE_SCHEMA = upper('{{schema}}')
        and last_altered <= current_date - {{ days }}
    {%endset%}

    {{ log('\nGenerating cleanup queries...\n', info=True) }}
    {% set clean_queries = run_query(clean_query).columns[1].values() %}

    {% for query in clean_queries %}
        {% if dry_run %}
            {{ log(query, info=True) }}
        {% else %}
            {{ log('Dropping object with command: ' ~ query, info=True) }}
            {% do run_query(query) %} 
        {% endif %}       
    {% endfor %}

{%endmacro%}