require_relative '../tools_helper'

cql = %Q(CREATE TABLE  visitor_logs
        (
            visitor_id bigint,
            date timestamp,
            id timeuuid,
            ip inet,
            customer_id bigint,
            product bigint, Primary Key(visitor_id, date, id, ip)) WITH CLUSTERING ORDER BY (date DESC, id DESC, ip ASC)
)
execute_lazy cql, []
