require_relative "../test_helper"
class TestAdmin < Minitest::Test

  def setup
    @admin_controller =TurboCassandra::Controller::Admin.new
  end


  def test_delete
    response = @admin_controller.delete 629
    assert response
  end

  def test_change_forgotten_password
    body = {'email' => "kirill.shakirov4@gmail.com"}
    new_password = @admin_controller.reset_password body.to_json
    refute_nil new_password
    assert new_password[:result]
    assert new_password[:password].size >= 10
  end

  def test_create_new_customer
    response = @admin_controller.create_new_customer 'kirill.shakirov4@gmail.com'
    refute_nil response
    assert_equal(response['action'], 'new')
  end

  def test_create_new_customer_admin
    customer_data = {
        'firstname' => 'Kirill',
        'lastname' => 'Shakirov',
        'email' => 'kirill.shakirov4@gmail.com',
        'group_id' => '2'
    }
    response = @admin_controller.create_new_customer_by_admin customer_data.to_json
    refute_nil response
    assert_equal(response['action'], 'new')
  end

  def test_create_order
    response = @admin_controller.create_order({'id' => 12 })
    refute_nil response
  end

  def test_change_password
    body = {'email' => "kirill.shakirov4@gmail.com", 'password' => 'test2'}
    res  = @admin_controller.change_password body.to_json
    assert res
  end

  def test_update_attribute
    params = {'id' => '487'}
    body = {firstname: 'Karim'}
    @admin_controller.update_customer params, body.to_json


  end




end