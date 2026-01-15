select 'CHARACTER SET '||value from v$nls_parameters where parameter = 'NLS_CHARACTERSET'
union all
select 'NATIONAL CHARACTER SET '||value from v$nls_parameters where parameter = 'NLS_NCHAR_CHARACTERSET';


PROMPT Alternative you can run this query:
PROMPT select * from database_properties where PROPERTY_NAME in ('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET');