require_relative '../tools_helper'

cql = %Q(CREATE TABLE  customer_logs
        (
            customer_id bigint,
            date timestamp,
            id timeuuid,
            ip inet,
            visitor_id bigint,
            product bigint, Primary Key(customer_id, date, id, ip)))
execute_lazy cql, []
