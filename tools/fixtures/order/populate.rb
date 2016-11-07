require_relative 'populate_helper'

order = TurboCassandra::Order.new
order_batch = TurboCassandra::OrderBatch.new
orders = read_orders_from_file

orders.each do |o|
  o['order_id'] = o['order_id'].to_i
  o['customer_id'] = o['customer_id'].to_i
  puts o['order_id']
  order_batch.remove_null_values o
  order.insert o

end