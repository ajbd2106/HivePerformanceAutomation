create database if not exists ${DB};
use ${DB};

drop table if exists part;

create table part
stored as ${FILE}
LOCATION '${LOCATION}/part'
TBLPROPERTIES('orc.bloom.filter.columns'='*','orc.compress'='ZLIB')
as select * from ${SOURCE}.part
cluster by p_brand
;
