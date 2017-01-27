require_relative "test_helper"
class TestCustomer < Minitest::Test

  def setup
    @order_model = TurboCassandra::CustomerBackEnd.new
  end

  def test_load_customer
    cr = @order_model.get_customer_info 487
    cr = JSON.parse cr
    p cr
  end

  def test_get_list
    list = @order_model.get_list
    refute_nil list
  end
end